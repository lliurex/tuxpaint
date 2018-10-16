#!/usr/bin/env python
# -*- coding: Big5 -*-
# Copyright: Song Huang <songhuang.tw@gmail.com>
# create: 2007/11/04
# License: GNU GPL 
ver = "0.1"

from optparse import OptionParser
from codecs import open as copen

if __name__ == '__main__':
    # parse script arguments
    optparser = OptionParser(usage='./%prog [options]', version="%prog "+ver)
    optparser.add_option("-o", "--outputfile",   action="store",  
                         help=unicode("��X�ɮת��W��","big5"))
    optparser.add_option("-m", "--phonemap",   action="store",
                         help=unicode("����P�`����Ӫ�(utf8 - expect file was xcin table:phone.cin)","big5"))
    (options, args) = optparser.parse_args()

    ## �]�w�D�n�ܼ�
    #  ��X�ɦW
    outfile = copen(options.outputfile, "w", "utf8")
    outfile.write("section\n\n")
    # ����P�`����Ӫ�
    phonemap = options.phonemap

    # �����X
    cinfile = copen(phonemap, "r", "utf8")
    (bopomofo, chinachar) = cinfile.readline().split()
    bpmf_count = 0
    bpmf_temp = bopomofo
    while bopomofo:
        if bpmf_temp == bopomofo:
            bpmf_count += 1
        else:
            bpmf_count = 1
	    bpmf_temp  = bopomofo
        chinacharnum = str(hex(ord(chinachar)))[2:]
        outfile.write("%s\t%s%s\t-\t# %s \n" % (chinacharnum, bopomofo, bpmf_count, chinachar))
	try:
            (bopomofo, chinachar) = cinfile.readline().split()
	except:
            break
    # ����
    cinfile.close()
    outfile.close()
