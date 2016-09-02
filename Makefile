TINKER = ~/.local/bin/tinker

post:
	$(TINKER) -p $(POST)

build:
	$(TINKER) -b

commit:
	git add blog * && git commit -a
