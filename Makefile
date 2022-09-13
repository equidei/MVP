build:
	cd onboarding && daml build
	cd onboarding && daml codegen js -o daml.js .daml/dist/*.dar
	cd onboarding && daml damlc visual .daml/dist/onboarding.dar --dot onboarding.dot
	cd onboarding && dot -Tpng onboarding.dot > onboarding.png
	cd ui && yarn install
	cd ui && yarn build

deploy: build
	mkdir -p deploy
	cp onboarding/.daml/dist/*.dar deploy
	cd ui && zip -r ../deploy/onboarding.zip build

clean:
	cd onboarding && rm -rf .daml
	cd onboarding && rm -rf onboarding.dot
	cd onboarding && rm -rf onboarding.png
	cd onboarding && rm -rf daml.js
	rm -rf deploy
	cd onboarding && rm -rf build
	cd onboarding && rm -rf node_modules
	cd onboarding && rm -rf yarn.lock

