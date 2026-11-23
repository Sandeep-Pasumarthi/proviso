import asyncio

from fastapi import APIRouter, Request, Response, status
from sqlalchemy import text

router = APIRouter(tags=["health"])

CHECK_TIMEOUT_SECONDS = 2


@router.get("/health")
async def health() -> dict[str, str]:
    """Liveness: the process is up. Touches nothing else."""
    return {"status": "ok"}


async def _check_postgres(request: Request) -> None:
    async with request.app.state.engine.connect() as conn:
        await conn.execute(text("SELECT 1"))


async def _check_redis(request: Request) -> None:
    await request.app.state.redis.ping()


@router.get("/ready")
async def ready(request: Request, response: Response) -> dict[str, object]:
    """Readiness: the dependencies this service needs are reachable."""
    checks = {"postgres": _check_postgres, "redis": _check_redis}
    results: dict[str, str] = {}
    for name, check in checks.items():
        try:
            await asyncio.wait_for(check(request), timeout=CHECK_TIMEOUT_SECONDS)
            results[name] = "ok"
        except Exception as exc:  # noqa: BLE001 - any failure means "not ready"
            results[name] = f"error: {type(exc).__name__}"

    all_ok = all(result == "ok" for result in results.values())
    if not all_ok:
        response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
    return {"status": "ok" if all_ok else "unavailable", "checks": results}
