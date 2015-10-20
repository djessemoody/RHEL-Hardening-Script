#!/bin/bash

outputrunlevel="hardeningoutput.txt"
installedrpms="hardeningoutput.txt"
intab="hardeningoutput.txt"
kerneltun="hardeningoutput.txt"

rm $outputrunlevel
rm $installedrpms
rm $intab
rm $kerneltun


function donecheck {
  printf "Done?(yes or no): "
  read amidone
  if [ $amidone = "yes" ];then
        echo "goodbye"
  elif [ $amidone = "no" ];then
        mainmenu
  else
        echo "invalid input"
        donecheck
  fi
}


function changevariables {
    echo "Select menu item number (all defaults hardeningoutput.txt)"
    echo "1) Change run level output"
    echo "2) Change installed rpm output"
    echo "3) Change inittab output"
    echo "4) Change kernel tuning output"
    echo "5) Back"
    printf "Selection (1-5) : "
    if [ "$selection" == "1" ];then
        printf "savefileas: "
        read outputrunlevel
    elif [ "$selection" == "2" ];then
        printf "savefileas: "
        read installedrpms
    elif [ "$selection" == "3" ];then
        printf "savefileas: "
        read intab
    elif [ "$selection" == "4" ];then
        printf "savefileas: "
        read kerneltun
    elif [ "$selection" == "5" ];then
        mainmenu
    fi
    
}



function kerneltuning {
    loc="/etc/sysctl.conf"
    quer="net.ipv4.conf.all.accept_source_route = 0"
    if ! grep -q "$quer" "$loc"; then
        echo "IP Source Routing NOT disabled" | tee -a $kerneltun
    fi
    quer="net.ipv4.conf.all.accept_redirects = 0'"
    if ! grep -q "$quer" "$loc"; then
        echo "Disable ICMP Redirect Acceptance NOT disabled" | tee -a $kerneltun
    fi
    quer="net.ipv4.icmp_echo_ignore_broadcasts = 1"
    if ! grep -q "$quer" "$loc"; then
        echo "Ignoring Broadcasts request disabled" | tee -a $kerneltun
    fi
    quer="net.ipv4.icmp_ignore_bogus_error_responses = 1"
    if ! grep -q "$quer" "$loc"; then
        echo "Bad Error Message Protection Disabled" | tee -a $kerneltun
    fi
    quer="net.ipv4.conf.all.log_martians = 1"
    if ! grep -q "$quer" "$loc"; then
        echo "Logging of spoofed packets, source routed packets, rediect packets disabled" | tee -a $kerneltun
    fi
    donecheck
}


function inittab {
    grep ':initdefault' /etc/inittab | tee -a $intab
    donecheck
}

function installedRPMs {
    rpm -qa | tee -a  $installedrpms
    donecheck
}


function runlevelcheck {
    chkconfig autofs && echo "autofs service is on" | tee -a $outputrunlevel
    chkconfig avahi-daemon && echo "avahi-daemon service is on" | tee -a $outputrunlevel
    chkconfig avahi-dnsconfd && echo "avahi-dnsconfd service is on" | tee -a $outputrunlevel
    chkconfig bluetooth && echo "bluetooth service is on" | tee -a $outputrunlevel
    chkconfig conman && echo "conman service is on" | tee -a $outputrunlevel
    chkconfig cups && echo "cups service is on" | tee -a $outputrunlevel
    chkconfig dhcdbd && echo "dhcdbd service is on" | tee -a $outputrunlevel
    chkconfig firstboot && echo "firstboot service is on" | tee -a $outputrunlevel
    chkconfig gpm && echo "gpm service is on" | tee -a $outputrunlevel
    chkconfig haldaemon && echo "haldaemon service is on" | tee -a $outputrunlevel
    chkconfig isdn && echo "isdn service is on" | tee -a $outputrunlevel
    chkconfig iptables && echo "iptables service is on" | tee -a $outputrunlevel
    chkconfig ip6tables && echo "ip6tables service is on" | tee -a $outputrunlevel
    chkconfig irda && echo "irda service is on" | tee -a $outputrunlevel
    chkconfig irqbalance && echo "irqbalance service is on" | tee -a $outputrunlevel
    chkconfig kdump && echo "kdump service is on" | tee -a $outputrunlevel
    chkconfig kudzu && echo "kudzu service is on" | tee -a $outputrunlevel
    chkconfig mcstrans && echo "mcstrans service is on" | tee -a $outputrunlevel
    chkconfig microcode_ctl && echo "microcode_ctl service is on" | tee -a $outputrunlevel
    chkconfig multipathd && echo "multipathd service is on" | tee -a $outputrunlevel
    chkconfig netconsole && echo "netconsole service is on" | tee -a $outputrunlevel
    chkconfig netfs && echo "netfs service is on" | tee -a $outputrunlevel
    chkconfig netplugd && echo "netplugd service is on" | tee -a $outputrunlevel
    chkconfig nfs && echo "nfs service is on" | tee -a $outputrunlevel
    chkconfig nfslock && echo "nfslock service is on" | tee -a $outputrunlevel
    chkconfig nscd && echo "nscd service is on" | tee -a $outputrunlevel
    chkconfig pcscd && echo "pcscd service is on" | tee -a $outputrunlevel
    chkconfig portmap && echo "portmap service is on" | tee -a $outputrunlevel
    chkconfig rdisc && echo "rdisc service is on" | tee -a $outputrunlevel
    chkconfig rhnsd && echo "rhnsd service is on" | tee -a $outputrunlevel
    chkconfig restorecond && echo "restorecond service is on" | tee -a $outputrunlevel
    chkconfig rpcgssd && echo "rpcgssd service is on" | tee -a $outputrunlevel
    chkconfig rpcidmapd && echo "rpcidmapd service is on" | tee -a $outputrunlevel
    chkconfig rpcsvcgssd && echo "rpcsvcgssd service is on" | tee -a $outputrunlevel
    chkconfig sendmail && echo "sendmail service is on" | tee -a $outputrunlevel
    chkconfig smartd && echo "smartd service is on" | tee -a $outputrunlevel
    chkconfig winbind && echo "winbind service is on" | tee -a $outputrunlevel
    chkconfig wpa_supplicant && echo "wpa_supplicant service is on" | tee -a $outputrunlevel
    chkconfig xfs && echo "xfs service is on" | tee -a $outputrunlevel
    chkconfig ypbind && echo "ypbind service is on" | tee -a $outputrunlevel
    chkconfig yum-updatesd && echo "yum-updatesd service is on" | tee -a $outputrunlevel
    chkconfig acpid || echo "acpid service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig anacron || echo "anacron service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig atd || echo "atd service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig cpuspeed || echo "cpuspeed service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig lvm2-monitor || echo "lvm2-monitor service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig messagebus || echo "messagebus service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig ntpd || echo "ntpd service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig network || echo "network service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig oracle || echo "oracle service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig oracleasm || echo "oracleasm service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig readahead_early || echo "readahead_early service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig readahead_later || echo "readahead_later service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig syslog || echo "syslog service is off or not available on this system" | tee -a $outputrunlevel
    chkconfig sshd || echo "sshd service is off or not available on this system" | tee -a $outputrunlevel
    donecheck

}

function mainmenu {
    clear
    echo "Select menu item number"
    echo "1) runlevel hardening check"
    echo "2) See Installed RPMs"
    echo "3) Kernel Tuning"
    echo "4) Change Output Variables"
    echo "5) Quit"
    printf "Your selection(1-5): "
    read selection
    if [ "$selection" == "1" ];then
        runlevelcheck
    elif [ "$selection" == "2" ];then
        installedRPMs
    elif [ "$selection" == "3" ];then
        kerneltuning
    elif [ "$selection" == "4" ];then
        changevariables
    elif [ "$selection" == "5" ];then
        echo "Goodbye"
    else
        mainmenu
    fi
}

mainmenu
