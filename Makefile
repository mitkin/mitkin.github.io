TINKER = ~/.local/bin/tinker

post:
	$(TINKER) -p $(POST)

build:
	$(TINKER) -b

commit:
	git commit -a
