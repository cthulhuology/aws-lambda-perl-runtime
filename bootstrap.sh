#!/bin/bash
#
# This file is going to be used to create a localinstall of perl (named bootstrap)
# We will use this to handle incoming events

export PERL_VERSION=5.28.1
export ARCH=$(uname -a)
export OS=linux

sudo yum groupinstall -y 'Development Tools'
sudo yum install -y expat-devel openssl-devel libxml2-devel
export PERL_BASE="/perl"
mkdir -p $PERL_BASE
cd $PERL_BASE
curl --create-dirs -L -o src/perl-${PERL_VERSION}.tar.gz http://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz
cd $PERL_BASE/src 
tar zxf perl-${PERL_VERSION}.tar.gz
cd $PERL_BASE/src/perl-${PERL_VERSION}
./Configure -des -Dprefix=$PERL_BASE/perl-${PERL_VERSION} -Dotherlibdirs=$PERL_BASE/perl-${PERL_VERSION}/lib/perl5
make
make install
curl -sL https://cpanmin.us | $PERL_BASE/perl-${PERL_VERSION}/bin/perl - --notest -l $PERL_BASE/perl-${PERL_VERSION} App::cpanminus JSON::Parse XML::Parser XML::Simple LWP LWP::Simple LWP::Protocol::https Archive::Extract Archive::Tar Archive::Zip CGI DBI Time::HiRes Encode File::Copy::Recursive Perl::OSType Module::Metadata Statistics::Lite Tie::Autotie Tie::IxHash FindBin::Real Getopt::Long List::Util Test::XML::Simple Test::XPath IO::String Paws version
export PERL5LIB="$PERL_BASE/perl-${PERL_VERSION}/lib/perl5:$PERL_BASE/perl-${PERL_VERSION}/lib/perl5/x86_64-linux:$PERL5LIB"
export PATH="$PERL_BASE/perl-${PERL_VERSION}/bin:$PATH"
