#!/usr/bin/env bash

main()
{
	echo ${1}

	cd ${1}
	# remove the var/run runtime deirectory
	rm var/run

	# change the hostname
	sed -i 's/localhost.localdomain/DeepCNC/' etc/hostname

	# enable the root user login
	sed -i 's/root:\*:/root::/' etc/shadow

	# use the ttymxc0
	rm etc/systemd/system/getty.target.wants/getty@tty1.service
	ln -s /lib/systemd/system/getty@.service etc/systemd/system/getty.target.wants/getty@ttymxc0.service
	exit $?
}

main $@
