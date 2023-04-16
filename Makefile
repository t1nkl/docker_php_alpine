.PHONY: build_alpine tag_alpine push_alpine



## BUILD
build_alpine: build_alpine_fpm_8_2 build_alpine_fpm_8_2_arm64
## BUILD FPM
build_alpine_fpm_8_2:
	docker buildx build --platform linux/amd64 -t t1nkl/php-alpine:fpm-8.2 -f 8.2/php/amd64/Dockerfile .
	docker buildx build --platform linux/amd64 -t t1nkl/php-alpine:fpm-8.2-swoole -f 8.2/swoole/amd64/Dockerfile .
build_alpine_fpm_8_2_arm64:
	docker buildx build --platform linux/arm64 -t t1nkl/php-alpine:fpm-8.2-arm64v8 -f 8.2/php/arm64v8/Dockerfile .
	docker buildx build --platform linux/arm64 -t t1nkl/php-alpine:fpm-8.2-arm64v8-swoole -f 8.2/swoole/arm64v8/Dockerfile .




## TAG
tag_alpine: tag_alpine_fpm_8_2 tag_alpine_fpm_8_2_arm64
## TAG FPM
tag_alpine_fpm_8_2:
	docker tag t1nkl/php-alpine:fpm-8.2 t1nkl/php-alpine:fpm-8.2
	docker tag t1nkl/php-alpine:fpm-8.2-swoole t1nkl/php-alpine:fpm-8.2-swoole
tag_alpine_fpm_8_2_arm64:
	docker tag t1nkl/php-alpine:fpm-8.2-arm64v8 t1nkl/php-alpine:fpm-8.2-arm64v8
	docker tag t1nkl/php-alpine:fpm-8.2-arm64v8-swoole t1nkl/php-alpine:fpm-8.2-arm64v8-swoole



## PUSH
push_alpine: push_alpine_fpm_8_2 push_alpine_fpm_8_2_arm64
## PUSH FPM
push_alpine_fpm_8_2:
	docker push t1nkl/php-alpine:fpm-8.2
	docker push t1nkl/php-alpine:fpm-8.2-swoole
push_alpine_fpm_8_2_arm64:
	docker push t1nkl/php-alpine:fpm-8.2-arm64v8
	docker push t1nkl/php-alpine:fpm-8.2-arm64v8-swoole



## UNBUILD
unbuild_alpine: unbuild_alpine_fpm_8_2 unbuild_alpine_fpm_8_2_arm64
## UNBUILD FPM
unbuild_alpine_fpm_8_2:
	docker image rm t1nkl/php-alpine:fpm-8.2-swoole -f
	docker image rm t1nkl/php-alpine:fpm-8.2 -f
unbuild_alpine_fpm_8_2_arm64:
	docker image rm t1nkl/php-alpine:fpm-8.2-arm64v8-swoole -f
	docker image rm t1nkl/php-alpine:fpm-8.2-arm64v8 -f
