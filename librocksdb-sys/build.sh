export CC=x86_64-linux-musl-gcc
export CXX=x86_64-linux-musl-g++
export AR=x86_64-linux-musl-ar
export PORTABLE=1
export CFLAGS="-DSNAPPY -fPIE -static"
export CPATH="${PWD}:${PWD}/snappy"
#echo $CPATH
if [ ! -f musl-rocksdb ]; then
	cp -r rocksdb musl-rocksdb
fi

if [ ! -f musl-rocksdb/librocksdb.a ]; then
    	cd musl-rocksdb
	make static_lib -j8
	cd ..
fi

if [ ! -f musl-snappy ]; then
        cp -r snappy musl-snappy
fi

if [ ! -f musl-snappy/libsnappy.a ]; then
	cd musl-snappy
	cmake . -DSNAPPY_BUILD_TESTS=OFF -DSNAPPY_BUILD_BENCHMARKS=OFF -DCMAKE_CXX_FLAGS="-fPIE"
	make -j 8
	cd ..
fi
