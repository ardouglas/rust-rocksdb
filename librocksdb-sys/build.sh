export CC=x86_64-linux-musl-gcc
export CXX=x86_64-linux-musl-g++
export AR=x86_64-linux-musl-ar
export CFLAGS="-fPIE -static"
export CPATH="${PWD}:${PWD}/snappy"
#echo $CPATH
if [ ! -f rocksdb/librocksdb.a ]; then
    	cd rocksdb
	make static_lib -j8
	cd ..
fi

if [ ! -f snappy/libsnappy.a ]; then
	cd snappy
	cmake . -DSNAPPY_BUILD_TESTS=OFF -DSNAPPY_BUILD_BENCHMARKS=OFF -DCMAKE_CXX_FLAGS="-fPIE"
	make -j 8
	cd ..
fi
#export LIBRARY_PATH="${PWD}/snappy:${PWD}/rocksdb:/home/adouglas/musl-cross-make/output/x86_64-linux-musl/lib"
