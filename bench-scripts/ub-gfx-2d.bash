echo -e ">> Starting UnixBench 2D Graphics benchmark ...\n\n"
cd @PREFIX@/byte-unixbench/UnixBench
./Run graphics && \
	echo -e "\n\n[o] The UnixBench 2D Graphics benchmark has complete sucessfully.\n\n"
