CXX = g++
CXXFLAGS = -m32 -g
AS = gcc
ASFLAGS = -m32 -g

SRC_DIR = src
ASM_DIR = src_TODO
BUILD_DIR = build
INCLUDE_DIR = include
MAIN_SRC = main.cpp

LIBS = lib/libTP3.a

SRCS_CPP = $(wildcard $(SRC_DIR)/*.cpp)
SRCS_ASM = $(wildcard $(ASM_DIR)/*.s)

OBJS_CPP = $(SRCS_CPP:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
OBJS_ASM = $(SRCS_ASM:$(ASM_DIR)/%.s=$(BUILD_DIR)/%.o)
OBJS_MAIN = $(MAIN_SRC:%.cpp=$(BUILD_DIR)/%.o)
OBJS = $(OBJS_CPP) $(OBJS_ASM) $(OBJS_MAIN)

TARGET = $(BUILD_DIR)/filters

CPPFLAGS = -I$(INCLUDE_DIR)

all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(ASM_DIR)/%.s
	@mkdir -p $(BUILD_DIR)
	$(AS) $(ASFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)
	rm -f *.bmp

run: $(TARGET)
	./$(TARGET)

zip:
	zip -r INF1600_remise_TP3.zip . \
		-x "*.git*" \
		-x "$(BUILD_DIR)/*" \
		-x "*.zip" \
		-x "*.htm" \
		-x "INF1600_A25_TP3_Énoncé_files" \
		-x "INF1600_A25_TP3_Énoncé_files/*"

remise: clean zip

.PHONY: all clean run remise zip
