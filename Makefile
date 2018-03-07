default: dev

dev:
		hugo server -D --disableFastRender

deploy:
		hugo
		scp -P '26386' -r public/* root@95.163.196.185:/usr/share/nginx/blog/