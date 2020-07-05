



prometeo:
	bash prometeo.sh



clear:
	find . -name "*tfstate*" -exec rm {} \;
	source variables.sh
	ssh root@$PM_HOST 'pct shutdown 4001; pct destroy 4001;'

