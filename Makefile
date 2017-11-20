TARGETS = GaborFilter Pyramid

OBJ = $(patsubst %.cpp, %.o, $(wildcard *.cpp))

CXXFLAGS = -O3 -Wall -Wextra -std=c++1z

CXXFLAGS += $(shell pkg-config --cflags opencv)
LDFLAGS = $(shell pkg-config --libs opencv)

ifeq ($(shell ccache -V &>/dev/null; echo $$?), 0)
	CXX := ccache $(CXX)
endif

# Rules
all: $(TARGETS)

$(TARGETS): % : %.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

.PHONEY: clean
clean:
	$(RM) $(TARGETS) *.o

run: all
	./GaborFilter you.jpg
	./Pyramid you.jpg
