
DOCKERCMD=podman
DOCKERFLAGS=

.PHONY: all snap-aligner bcftools r-tagc

all: snap-aligner bcftools r-tagc

snap-aligner:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:2.0.1 -f $@/Dockerfile $@

bcftools:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:1.15.1 -f $@/Dockerfile $@

r-tagc:
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:4.3.1-TAGC -f $@/Dockerfile $@
