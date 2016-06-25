CC=${HOST_GCC}
export CC

all:
	-make -C amadec install
	-make -C amavutils install
	-make -C amcodec install
    
install:
	all

clean:
	-make -C amadec clean
	-make -C amavutils clean
	-make -C amcodec clean
