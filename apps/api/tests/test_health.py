import pytest
from fastapi.testclient import TestClient

from proviso_api import health
from proviso_api.main import create_app


async def _ok(request: object) -> None:
    return None


async def _fail(request: object) -> None:
    raise ConnectionError("down")


def test_health_returns_ok() -> None:
    response = TestClient(create_app()).get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_ready_ok_when_dependencies_up(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(health, "_check_postgres", _ok)
    monkeypatch.setattr(health, "_check_redis", _ok)
    response = TestClient(create_app()).get("/ready")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_ready_503_when_redis_down(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(health, "_check_postgres", _ok)
    monkeypatch.setattr(health, "_check_redis", _fail)
    response = TestClient(create_app()).get("/ready")
    assert response.status_code == 503
    assert response.json()["checks"]["redis"].startswith("error")
