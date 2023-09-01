
DOCKERCMD=podman
DOCKERFLAGS=
APPTAINER=apptainer

.PHONY: all sif snap-aligner bcftools r-tagc

all: snap-aligner bcftools r-tagc

sif: snap-aligner-sif bcftools-sif rtagc-sif


SNAP_ALIGNER=snap-aligner
SNAP_ALIGNER_VERSION=2.0.1
BCFTOOLS=bcftools
BCFTOOLS_VERSION=1.15.1
RTAGC=r-tagc
RTAGC_VERSION=4.3.1-TAGC

$(SNAP_ALIGNER):
	@echo Building snap-aligner image...
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:$(SNAP_ALIGNER_VERSION) -f $@/Dockerfile $@

snap-aligner-sif: $(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).sif
$(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).sif: $(SNAP_ALIGNER)
	$(DOCKERCMD) image push $(SNAP_ALIGNER):$(SNAP_ALIGNER_VERSION) oci-archive:$(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).tar
	$(APPTAINER) pull --force $(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).sif oci-archive:$(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).tar
	rm -f $(SNAP_ALIGNER)-$(SNAP_ALIGNER_VERSION).tar


$(BCFTOOLS):
	@echo Building bcftools...
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:$(BCFTOOLS_VERSION) -f $@/Dockerfile $@
bcftools-sif: $(BCFTOOLS)-$(BCFTOOLS_VERSION).sif
$(BCFTOOLS)-$(BCFTOOLS_VERSION).sif: $(BCFTOOLS)
	$(DOCKERCMD) image push $(BCFTOOLS):$(BCFTOOLS_VERSION) oci-archive:$(BCFTOOLS)-$(BCFTOOLS_VERSION).tar
	$(APPTAINER) pull --force $(BCFTOOLS)-$(BCFTOOLS_VERSION).sif oci-archive:$(BCFTOOLS)-$(BCFTOOLS_VERSION).tar
	rm -f $(BCFTOOLS)-$(BCFTOOLS_VERSION).tar

$(RTAGC):
	@echo Building r-tagc
	$(DOCKERCMD) build $(DOCKERFLAGS) -t $@:$(RTAGC_VERSION) -f $@/Dockerfile $@

rtagc-sif: $(RTAGC)-$(RTAGC_VERSION).sif
$(RTAGC)-$(RTAGC_VERSION).sif: $(RTAGC)
	$(DOCKERCMD) image push $(RTAGC):$(RTAGC_VERSION) oci-archive:$(RTAGC)-$(RTAGC_VERSION).tar
	$(APPTAINER) pull --force $(RTAGC)-$(RTAGC_VERSION).sif oci-archive:$(RTAGC)-$(RTAGC_VERSION).tar
	rm -f $(RTAGC)-$(RTAGC_VERSION).tar
