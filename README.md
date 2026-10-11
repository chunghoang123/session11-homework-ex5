# Session 11 - Homework Ex5: Job Build & Push Docker Image với needs

Mở rộng từ Ex4, tách thành 2 Job trong `.github/workflows/ci.yml:7`:

- `test`: chạy Gradle test, `bootJar`, upload `app-jar` (giống Ex4 nhưng không login).
- `docker-build` với `needs: test`, chỉ chạy khi `test` xanh:
  - Checkout, `docker/login-action@v3` (dùng `secrets.REGISTRY_TOKEN`)
  - `docker/build-push-action@v5` build `Dockerfile` đẩy lên `ghcr.io/<owner>/session11-homework-ex5:latest` + `:<sha>`

## Kiểm tra
- Tab Actions hiện sơ đồ 2 Job nối mũi tên `test` → `docker-build`.
- Sửa code làm đứt test → `docker-build` chuyển `Skipped`.

## Dockerfile
Multi-stage: `eclipse-temurin:17-jdk` build JAR, `eclipse-temurin:17-jre` chạy `app.jar`, expose 8080.
