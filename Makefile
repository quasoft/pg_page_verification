## Makefile for pg_page_verification

# ./server/storage/checksum_impl.h
#
# Note: you may need to redefine
# Assert() as empty to compile this successfully externally.

# FIX: Manually linking some of the Win32 specific object files,
# so the path to the full source tree of postgres (containing all .o files) has
# to be manually specified in PGSQL_SRC_DIR
PGSQL_SRC_DIR = /home/user/postgresql-16.1/src
PGSQL_OBJ_DIR = ${PGSQL_SRC_DIR}/port/

# Requires pg_config to have valid values
PG_CONFIG = pg_config
PGSQL_CFLAGS = $(shell $(PG_CONFIG) --cflags)
PGSQL_LDFLAGS = $(shell $(PG_CONFIG) --ldflags)
PGSQL_INCLUDE_DIR2 = $(shell $(PG_CONFIG) --includedir-server)
PGSQL_INCLUDE_DIR = $(shell cygpath -u ${PGSQL_INCLUDE_DIR2})
PGSQL_LIB_DIR2 = $(shell $(PG_CONFIG) --libdir)
PGSQL_LIB_DIR = $(shell cygpath -u ${PGSQL_LIB_DIR2})
PGSQL_PKGLIB_DIR2 = $(shell $(PG_CONFIG) --pkglibdir)
PGSQL_PKGLIB_DIR = $(shell cygpath -u ${PGSQL_PKGLIB_DIR2})
PGSQL_BIN_DIR2 = $(shell $(PG_CONFIG) --bindir)
PGSQL_BIN_DIR = $(shell cygpath -u ${PGSQL_BIN_DIR2})

pg_page_verification: pg_page_verification.c
	x86_64-w64-mingw32-gcc ${PGSQL_CFLAGS} ${CFLAGS} ${PGSQL_LDFLAGS} ${LDFLAGS} -o pg_page_verification \
-I${PGSQL_INCLUDE_DIR} -I${PGSQL_INCLUDE_DIR}/port/win32 \
-L${PGSQL_LIB_DIR} -L${PGSQL_PKGLIB_DIR} -lpgport -lpgcommon -lpq \
pg_page_verification.c \
${PGSQL_OBJ_DIR}pgsleep.o ${PGSQL_OBJ_DIR}strerror.o ${PGSQL_OBJ_DIR}snprintf.o ${PGSQL_OBJ_DIR}pgstrcasecmp.o \
${PGSQL_OBJ_DIR}path.o ${PGSQL_OBJ_DIR}preadv.o ${PGSQL_OBJ_DIR}pwritev.o ${PGSQL_OBJ_DIR}explicit_bzero.o \
${PGSQL_OBJ_DIR}getpeereid.o ${PGSQL_OBJ_DIR}inet_aton.o ${PGSQL_OBJ_DIR}mkdtemp.o ${PGSQL_OBJ_DIR}strlcat.o \
${PGSQL_OBJ_DIR}strlcpy.o ${PGSQL_OBJ_DIR}strtof.o ${PGSQL_OBJ_DIR}getopt.o ${PGSQL_OBJ_DIR}getopt_long.o \
${PGSQL_OBJ_DIR}dirmod.o ${PGSQL_OBJ_DIR}kill.o ${PGSQL_OBJ_DIR}open.o ${PGSQL_OBJ_DIR}system.o \
${PGSQL_OBJ_DIR}win32common.o ${PGSQL_OBJ_DIR}win32dlopen.o ${PGSQL_OBJ_DIR}win32env.o ${PGSQL_OBJ_DIR}win32error.o \
${PGSQL_OBJ_DIR}win32fdatasync.o ${PGSQL_OBJ_DIR}win32getrusage.o ${PGSQL_OBJ_DIR}win32link.o ${PGSQL_OBJ_DIR}win32ntdll.o \
${PGSQL_OBJ_DIR}win32pread.o ${PGSQL_OBJ_DIR}win32pwrite.o ${PGSQL_OBJ_DIR}win32security.o ${PGSQL_OBJ_DIR}win32setlocale.o \
${PGSQL_OBJ_DIR}win32stat.o

install:
	install -m 755

clean:
	rm pg_page_verification
