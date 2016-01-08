# Fix dependency 
http://askubuntu.com/questions/689123/vmware-wont-work-after-ubuntu-upgrade
	
The solution below applies to versions of VMWare prior to 12.1.0. The 12.1.0 version of VMWare does not require this fix.

VMWare and VMPlayer are in fact looking for a specific library string. You can execute VMWare/VMPlayer from the terminal by executing

	export LD_LIBRARY_PATH=/usr/lib/vmware/lib/libglibmm-2.4.so.1/:$LD_LIBRARY_PATH
then vmware or vmplayer

I made this a permanent change on my system by executing instead

executing sudo nano /usr/bin/vmplayer and adding the line

export LD_LIBRARY_PATH=/usr/lib/vmware/lib/libglibmm-2.4.so.1

after the line export PRODUCT_NAME...

# Compile vmware module 
https://communities.vmware.com/thread/516196?start=0&tstart=0


	sudo -E -s
 
	cd /usr/lib/vmware/modules/source/ 
 
	cp vmnet.tar vmnet.tar.original
 
	tar xvf vmnet.tar vmnet-only/vmnetInt.h
	nano vmnet-only/vmnetInt.h

	extern struct proto vmnet_proto;
	#ifdef VMW_NETDEV_HAS_NET
	#  define compat_sk_alloc(_bri, _pri) sk_alloc(&init_net, \
                                                PF_NETLINK, _pri, &vmnet_proto, 1)
 
	tar -uvf vmnet.tar vmnet-only/vmnetInt.h
 	rm -rf vmnet-only/

# Optimize perfs
http://costatechnet.blogspot.pt/2015/10/vmware-vmx-eating-cpu-100-and-freezes.html
