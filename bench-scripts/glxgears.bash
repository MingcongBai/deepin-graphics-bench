echo ">> Running glxgears benchmark (60 seconds) ...\n\n"
timeout --preserve-status 60 \
	@PREFIX@/bin/glxgears
echo "\n\n[o] The glxgears benchmark (60 seconds) has completed successfully."

echo '>> Starting the next benchmark: UnixBench 2D Graphics ...'
xterm -hold -e "@PREFIX@/bench-scripts/ub-gfx-2d.bash"
