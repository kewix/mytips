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

# Compile vmmnet module 
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
 	
# Compile vmmon module  (Ubuntu 16.04) 

If you get this error : 
/tmp/modconfig-xxx/vmmon-only/linux/driver.c: In function ‘cleanup_module’:
/tmp/modconfig-xxx/vmmon-only/linux/driver.c:403:8: error: void value not ignored as it ought to be
    if (misc_deregister(&linuxState.misc)) {


	sudo -E -s
 
	cd /usr/lib/vmware/modules/source/ 
 
	cp vmmon.tar vmmon.tar.original
 
	tar xvf vmmon.tar vmmon-only/linux/driver.c
	nano vmmon-only/linux/driver.c
	
	Replace content line 403 with this :
	#ifdef VMX86_DEVEL
	   unregister_chrdev(linuxState.major, linuxState.deviceName);
	#else
	   misc_deregister(&linuxState.misc);
	//   if (misc_deregister(&linuxState.misc)) {
	//      Warning("Module %s: error unregistering\n", linuxState.deviceName);
	//   }
	#endif

	tar -uvf vmmon.tar vmmon-only/linux/driver.c
 	rm -rf vmmon-only/
 	
 	sudo vmplayer
