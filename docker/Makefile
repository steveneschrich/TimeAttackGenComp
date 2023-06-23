
DOCKERCMD=podman
DOCKERFLAGS=--platform=linux/amd64

.PHONY: all snap-aligner bcftools r

all: snap-aligner bcftools r

snap-aligner:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:2.0.1 -f $@/Dockerfile $@

bcftools:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:1.15.1 -f $@/Dockerfile $@

r:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:4.3.1 -f $@/Dockerfile $@