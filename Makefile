BUILD_DIR = build
PCAP_DIR = pcaps
LOG_DIR = logs

source = $(wildcard *.p4)
compiled_json := $(source:.p4=.json)

P4C_ARGS += --p4runtime-files $(BUILD_DIR)/$(basename $@).p4.p4info.txt

run_args += --topo topology/topology.json
run_args += --switch_json $(BUILD_DIR)/hello-world.json
run_args += --behavioral-exe simple_switch_grpc

all: run

run: build
	sudo python3 utils/run_exercise.py $(run_args)

stop:
	sudo mn -c

build: dirs $(compiled_json)

%.json: %.p4
	p4c-bm2-ss --p4v 16 $(P4C_ARGS) -o $(BUILD_DIR)/$@ $<

dirs:
	mkdir -p $(BUILD_DIR) $(PCAP_DIR) $(LOG_DIR)

clean: stop
	rm -f *.pcap
	rm -rf $(BUILD_DIR) $(PCAP_DIR) $(LOG_DIR)
