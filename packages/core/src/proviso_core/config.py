from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """App configuration, read from PROVISO_* environment variables or .env."""

    model_config = SettingsConfigDict(
        env_prefix="PROVISO_", env_file=".env", extra="ignore"
    )

    env: str = "local"
    # Defaults match compose.yml; real values come from Secrets Manager in AWS.
    database_url: str = "postgresql+asyncpg://proviso:proviso@localhost:5432/proviso"
    redis_url: str = "redis://localhost:6379/0"
    cors_origins: list[str] = ["http://localhost:5173"]


@lru_cache
def get_settings() -> Settings:
    return Settings()
