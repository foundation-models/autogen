init:
	# dvc init
	dvc remote add -d assistant azure://aidrive/assistant
.PHONY: init

dvcpush:
	@echo "Pushing to DVC..."
	cd samples/apps/autogen-studio/frontend && \
	dvc add node_modules && \
	dvc add build
	dvc push
	@echo "Done."
.PHONY: dvcpush