#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Solver subdirectory
  --exclude-subdir  exclude the Solver subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "solver Installer Version: 0.1.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the solver will be installed in:"
    echo "  \"${toplevel}/Solver\""
    echo "Do you want to include the subdirectory Solver?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Solver"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +155 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Solver"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� t!kb �]xTՕ3�!$�QF��3!	�&��KM$%�����dB�&3��������]��n췭��p����� Vh�jP����F�:���=�ߛ��'�����Br���{�=�ܿ�����Ñ��g�^��n����^�j��+*\PXR�-.)r{}JJ
%w�g�
�	5Ub�`ks@��M�](��C��OB=�"ڼ)dV�Q���M�aQa���ž^����TJ�������r��b�x�t����ل/�xS,��L*�r���[|�N���z���!���/ҙ��Z8��)�Y{��J�t>;�pS\�G'�)�/���@��|>y+	�]������B>+��D�5��S�UO�=��O)�+R�����t"]!�)�}�Q�a8�U�|�e��IOYy_�|�TK������ڡߦ����oח�on������k+-�WR�ID=��^�ԧV�X�ڭa6N�)�G����ޞ;�>.�v��^����ɰ�4Mo���yR�?Ys�n�M��G�6�}�kM}3��^j��x�|�l넇cg���Ynf�'�����c|�I��&x���k���&�ˬ�����8�hF�e�1>7��?b"�ے1~�D΃&vv��A6�󡉜/���-9w���93}L�0i�q&xҤ{M�&�k&��2��	>KJ�Y|���ݲM��DϧL�\b�o]&�,1�����O��=M��+���s	�N�,�Z�/���3�M`�+��R5�o�S��s���r�,hT�oƑ�e�b5��	�!8w.��K$E���(hS�*��T�V)�xhc8���U˛��Pm��9D�cn��F]�(��6��WXH�� 2�l�֨>_�)W�x �&*��� ��/�UT7���J�Be�5���Y���5�O���ذ��-��a
)DB�H�T�f~�&\�����o��0m�5��'�k�FmN�_�Q( h��Uj��[�\ۚ"��X��)~?.	[��on�� �j�ex�K�X(�௾!�� �[2����Z@��p4�@�PQE$������6ţ��u=���-5�4L�������C�x4�hn�Bq!%���p4�Fx[���H����ɫ���iI8��U�Hm���z�F�t�-A�����(50�c[����7j���q�7`H�!���ڌ��EÑ��!�ئ�R!UiE6�MÝ$a���=��o��h"�kX���*��#i��h�4���]���p���r4@��0���A�l�k��V��H'����B擔���0TyM(��B�A���b�:�Jc ��f5�V�M�H�q��0���� t#��9vUeŲ�J���S,�Z�\Y��jX��|���e�ϳ��k�B�"O��gц�
�l�/�����X�چyܯ�hZ����w��w�'4��ٱt��N��Zg�ǣ����F������z�D$w�o��x�mJ8��� �w�ȳs�l���7���;��.����sh�iZKy��d� ����}~�BK��|B���ShY�7P9�z��LRO�B�=3��� �O��~���9���p��8<���>��>���r�t�^ng�h�s���}1�p8�_#��ί�-��y��}�C��p���p��\��9� ���s�9<��s���8|<�'9|"�rx�qx.�KJ��`�;9���.���8�����W>�_��^���>���8|��~1�Ws�%���gp���Û8|&��8�2o���9���gq�=~����8|7����^������9|�_��{9|�4��Xca,����?�v^���q�!w�=l;�Tk�_�xޱǧ��t�$�J͹�sN߄"N{3�J�ļ�4ފ�}o������G5ގ��k�8�ߥ�٘�S��h�x�Q�'`�\�'bާ�9��B�s1?I��0o�x'�O�g���_�'��k�dR����_㧐�k�TR��F����k�tR����_�g��k����?��_�/#����I�5~��'�w��k���%���_E��x�M���7� ������o�O�����=�?*���	���+����?%�?��
���A���N��&��"�!�_/�u_%�~�_*��?O���e?U�s�.�,�x�{]�n��ޒ;�V�V����{r����}h�z
���	l��گDdѐ:�����o|j�9�Mo�)���Ȟb�_.8/w���r��o�&[^��W����R��@#֋�G��/ͅ�.�έ�;�~a1��uT͑���L�عT*� ������-�!�.����.� _ym�ױ�;kN>�O����;����.�a;��v���Hj�|J�����v�G�KCvPd3 ,�Nv��i��j����{��{�v�]/Ag�!g��Fg�/y3L�݀��{�N�:�\kE��A�^0䃗 �$�Ea��O�r�9t Y��)��&��{�j�]I�n�	�	=����	���^���U�yA��s�bXΎy-��]��]���/}�J��ñ��^�5 w���ř�v��jO��"��GՁb^�Mr y�ǈ�wC��?��n�%���%w�0�u ��ܵL�A�|	%�D�JMQS
��帴)��h,�!�N� ����IW���������N�8Gʑ��F�ԉ���x>v[����Y������v��u�c�9Kk�]ۆR)���}ǊLݺ�#�P���-$��4��ך�gP�g�~#�-�R�r׶$�G��1��;�?��[�G�^I��`I�9����JpQ{���A "T{r�G��ɴ5�]'�헎��S&�G�g�<j��)Dz��l�S�rt���YP��,���,X��,�q��9Z���8�;K!��O���B{�{ѾC�HZdK�����q���|��w�%��ߖ^�^%/zM����rǎ�Chs���뭔�f���;_Q]s�UG�![�(��)�Kf���@��ӁN7�F{����ʋ�I?hЙ����Y�����\J-w?�l"w?�+ӍUvw�(O�wuN!�/"P�a�0�Os�=���=�$�Oa�����!��#�m?�F���N�l�n���Wh�YK��!�3�����JK�^?���;�}m����]�]�Z宺��]7���3�� }���ݘ��y!��{���:N䣎�`�����듸#C�/ca���G���#�S,wW��xFX���rVu*��V��Cx���ƍ+ZO�H��
	�͠X�]�)�堢ަ�!���:��z� j�
�;(,��j�N�0B'a~�����g��v�>@LLV�`[�<�>��A�7Z��C��prnZ
�#���IԽ���L�"�8�r���1&���
�����3�*@2D2m�%ǋH+H��LZ��2y�Ym�O^wVk��L��}�J�бmHr>З9ݢ������2�&��D��d��[h�%��K�F���?(��;!jX��B��QѺ�]��j��:��{)��$���&V���@���֌u52�]g�������.gZ����>/^�>,�k]�K����ZG��^�����:��`*�v�чvh�܂.� ޕ�݅�[~?U��v�ۇr�@�:�|��M�Ϣ�$��)j��Eh��YdU����|2M�Ϻ�D\|u!\�+�H�����Fba�˭��J;�R�kA��:��T�$�%��]W>@�PM2Ңͧt|��}z#�v��$�}��7cǁ�9��?�Kx�4��>���Nr y�5{�ҷ9I�9E�S�U{�	�6��2zX'K��<��rRY� ����y��gQE֝�:ݓD�$?�}�d���罺~n90�Mjڎ4�
��˃�2�����S�A����+{�����������*��/�-�:W'��{��ʂO�3�d�=���:��z�S�u���/+��)OMyC��o����]�|�����ח�^��ol�8gmמg��kiO���Xca,���0��Xc��;X�[�s�6�{�[j+D�� ��g�ܑ��fw$��7���@|�`��!���-�H ��?�\9��I�#}$�3��ٖKmK�Yp�'��7R�|�$���JU ��=pI��y��GS�>�?'�j�IRv2�����}@�@w���O �Z��x*��^��� ���D*��l��S����@�@�Z�}��:����$��@Y���W��z-�>��h��w���{��A_�f��Z���,m.˥9َ���?�;�N��{�+������:�P�'R)ϵ2o��7;ڥ�g,�f��+�\�
y� ؀k�����{���~v�9�� ���ۺ<w�5q��VWbM���եL��T�r��I���ږ��j��#���Ң4��#P�'�/+���;l�����B[����	G���C|�t���	P9�?��O ͚ŕ��Y�i9�A����˩H��Ŀ�u�r*5=�G}�q�l��M���f=f��a+N�7��>:��S���Z���ku���WB�?C|�O�o������1������ ������&�q�C�*�������]�r�@���k^�h���5.�A�����b6��i��F��Y�~��~��{伍��Y��wiy� �}07��t���$��[�k҅�^+�\�[+��g��{��y�;�+�w���J;�W�E�J���y������/�s-�s�3����<E��
�u�
$�1��7l�C{��v�b?m��o��=�}���3��qC6��d���.=�e?�%=b����$4~*eq���߱�c���R��q���$�ϱ̸%(I�-������z�ҿZ��Qȗ[���"�m!�&F�0���o����f}�"�a��E��b��gi����j)��t,���0���f`�:�9Nvns���,XL��z���ڙ=7!��a�I;��Ρ�3i�,';��Η�}+;S���T�^z���<}4;�8@����(�ggYy�Y<ؙ�{�yC���@#�~��}dg�.���d��{���HV>;K��}�"��P�<�w�C�)ʳ3������)�Y��̿��'�2J�)�@i��vJwR�K�J�(��t��AJ�aB�nJ���QZM�Jc��S���^J�P�Gi?���C��p��R7�^J�(��t����v�Z��/_�ί�o����E�"�w��s��z=�"����.�0�n3­��8=n�����,�q�6~��8m���lm|�q�����xm���	ڸ�����s�7�`Vs�yR̠�m�Sj7�]��F=>I�/���_C~��O�O�v��S�>�>M������|�������%��fw6��qX6�i?Rz����<�q�Y�΃���(���+(.��q3���ty(��י�i�rz9[p�L;�6���8�d�Q�/���E��eZ�tݯ�x��l?���,�^�2�r����r�������+w�ʭ��~���Bz�����"=m�����b����sy�^���O�����4�3-���Hq�?`9���,���5����?9��lE�.����WL�����sƦ�כlȿBzc��N9/ڌ�����[�E�_B��|*|9����.9G�?<륚����a?�.�q:��dD?�s �r�u=sAz����x���o��o��ى��?	�����|�	>��5s��k�ޙM�� m�Ϗg{����)n�q���E�	����;�����S�Z�ߘ��Ǜ��O�O����y7����q���e9�&��:�8��&��	~n�o�vL4�i��O4���$�щ�^/Q�5=/�!�5�nu��1�J��jH7-�H������3��z=~�D��\�O���:�L��.�?�k�?�3��#��=����>��������>��
Q|^���
�KT����uy/�=���'��>��|��ӐI�m&�.���ѽ&�s\����v��8�|���R�I��q�&x���?��&��?�Մ����	Ji���ڢ�ӄ�(Qecs�9�S��hm��іXsH5xJ�%>�DȷZX	��-J(�ƷH��@KHihmi�Y8N���.i��� ��	�b�]�oQ,
�6����IT����H�E>� N��0��%)�H��"���%eU��e啐��^� ~��񖀊�j#��)�.Ғ���~�RSOx~�|D�פ�Ҕ�kʫ�����!����:�/SP^�FRV�rcyU�r�ә�A`Ov��W����*���*����OsȊ|fn�Ʒ ǭ�qbq�U+Q�V��f$G���ʲ2��]�ɫ������{��IE��F����H7r�[��5�#Jk"�0��Q�<���]��8o������V�hN(�%CĠ2�k�#�5��8"w�Ͷ�fO<��1��j�6V_%�!U�`�=/R�T-�|�NWC�O3$i./�&fF1s�;r'�u2�(*�A�^6
>N�5�*�ͪ�C�:7�ä́t��%��\����%q�+�%�	��5�|o�����js.RŁ����6l�ґ��hx���p�%۰VE-�M��5�it�jd��x�P`�j#3᪯�)�������7k!��Z��F�4۠g��{7�dj���}��=2�+�S�Xa��9s�4l�҆]/�l�Ѽ,<��(ɥJ����Q�f�ؗ�Au���qMc�h���6��u�?J���7�M����J�M�d:3�bn2�S���ޥV ��z$�M}b�
���;���G+��;!�l��v�`5؈���Ù^�h#]�2\E����[P6�	-����e�V�#��}ڗCt����ԛ8��2���0A�}�t"��ѭ;q���@�wk��t!��7VF�;*��1Fi�꿇b,4��z�H�Ė5PT��Į�mPL�D�j�]��Ga�[8��5��0/�@!�e����5M��aK� T���M0���|�Q .j���*֬"-`D�K��(�H���6�����G�m�'�D��45����9�Ԃ��"�]#9�p�U����<0AI�`��%Q�Q'��y�#7�g���`x䂎�in��:��J���w��?���(������|1���s6�����=F�(��S�G�-'r��!4Jd��Y~�5,�M�ޛ`4*(��N��c���+m��
�+yg���=F�Hi������P��g�k0�ޣ��꿋�_Fy�^��=.��A�G��7�pp�)�C]�2��[B~����V}z�@��I�ς��#�g�0Zv��&�g�bt*�d�@�g����
�E��J���w<ҋ�(�7�n�Y���g�2�������g��(���M���}�~s���!P��|��g�ȕ������?���NS}��Y@g~�q������{��=I������|���=7�&LX��s���V��/��\��%��������S&��Z2�q���=`���P�4;@��K���k<�;���Vx/N��'��Ϗ�H� �ca,���0��=�� �  