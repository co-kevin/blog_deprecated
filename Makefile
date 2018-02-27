default: dev

dev:
		hugo server -D --disableFastRender

deploy:
		hugo
		scp -r public/* root@hookszhang.space:/usr/share/nginx/blog/