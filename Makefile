VERSION=$(shell python -c "import voropy; print(voropy.__version__)")

# Make sure we're on the master branch
ifneq "$(shell git rev-parse --abbrev-ref HEAD)" "master"
$(error Not on master branch)
endif

default:
	@echo "\"make publish\"?"

tag:
	@echo "Tagging v$(VERSION)..."
	git tag v$(VERSION)
	git push --tags

README.rst: README.md
	pandoc README.md -o README.rst
	python setup.py check -r -s || exit 1

upload: setup.py README.rst
	python setup.py sdist upload --sign

publish: tag upload

clean:
	rm -f README.rst