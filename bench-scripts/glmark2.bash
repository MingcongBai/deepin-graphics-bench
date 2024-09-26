echo -e ">> Runnning glmark2 benchmark ...\n\n"
@PREFIX@/bin/glmark2 && \
	echo -e "\n\n[o] The glmark2 benchmark has completed successfully.\n\n"

echo '>> Starting the next benchmark: glxgears (60 seconds) ...'
xterm -hold -e \
	@PREFIX@/bench-scripts/glxgears.bash
