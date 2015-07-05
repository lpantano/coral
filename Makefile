CXXFLAGS = -O3 -Wall

CXX = g++

# samtools
SAMTOOLS_DIR = samtools-0.1.18
SAMTOOLS_CFLAGS = -I$(SAMTOOLS_DIR)
SAMTOOLS_LDFLAGS = -L$(SAMTOOLS_DIR) -lbam -lz



CXXFLAGS = -Wall -O3 $(SAMTOOLS_CFLAGS)
#CXXFLAGS = -Wall -g $(SAMTOOLS_CFLAGS)
LDFLAGS = $(SAMTOOLS_LDFLAGS)

PROGS = bin/compute_genomic_lenvectors bin/index_genomic_lenvectors \
        bin/compute_locus_lenvectors
SRCS = $(wildcard *.cpp)
PROGS = $(patsubst %.cpp,bin/%,$(SRCS))
SCRIPTS += $(patsubst %,bin/%,$(wildcard *.rb))

all: Makefile bin $(SAMTOOLS_DIR)/libbam.a $(PROGS) $(SCRIPTS)

bin:
	mkdir bin

bin/%: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ $< $(LDFLAGS)

bin/%.rb: %.rb
	cd bin && ln -s ../$< $<

$(SAMTOOLS_DIR)/libbam.a: 
	@echo "Building samtools..."
	cd $(SAMTOOLS_DIR) && make

clean:
	rm -f bin/*
	cd $(SAMTOOLS_DIR) && make clean && cd -


