.PHONY: build serve

build:
	docker build . -t helloworldwebapi

serve:
	docker run --rm -p 5000:5000 helloworldwebapi