
INTX=/Developer/usr/bin/install_name_tool
OTX=/Developer/usr/bin/otool

################################################################################
# Override CFLAGS
################################################################################


################################################################################
# Override LDLAGS
################################################################################

PLATFORM_FRAMEWORKS += Foundation Cocoa # snow leopard
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PROJECT_FRAMEWORKS))
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PLATFORM_FRAMEWORKS))
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PROJECT_ADDONS_FRAMEWORKS))

# remove fmodex and GLUT
# use them from ./bin/{frameworks, libs}
LDF=$(shell echo "$(LDFLAGS)" | sed  -e "s/\-L\.\.\/libs\/fmodex\/lib\/osx//g" -e "s/\.\.\/libs\/glut\/lib\/osx/\.\/bin\/frameworks/g" )
L=$(strip $(foreach l,$(LDF),$(shell echo "$(l)" | grep -v GLUT. )))

# Give back.
LDFLAGS := $(L)

################################################################################
# Override OF_CORE_LIBS
################################################################################

LIBS=$(shell echo "$(OF_CORE_LIBS)" | sed -e "s/\.\.\/libs\/fmodex\/lib\/osx\/libfmodex\.dylib/\.\/bin\/libs\/libfmodex\.dylib/g" )

# Give back.
OF_CORE_LIBS := $(LIBS)
