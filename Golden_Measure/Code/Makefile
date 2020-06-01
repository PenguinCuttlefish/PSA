CPP=g++

# directories
INCLUDES_DIR=include/
OBJECT_DIR=obj/
SOURCE_DIR=src/
BIN_DIR=bin/

EXE_NAME=PSA

CPPFLAGS=-g -std=c++11 -I $(INCLUDES_DIR) 

OBJECTS = $(OBJECT_DIR)Search.o

#-----------------------------------------------------------------------------------------------------------
# DEFAULT RULES
#-----------------------------------------------------------------------------------------------------------

$(OBJECT_DIR)%.o: $(SOURCE_DIR)%.cpp 
	@echo "🛠️"
	@$(CPP) -c -o $@ $< $(CPPFLAGS) -Wall
    
$(EXE_NAME): $(OBJECTS)
	@echo "🔗 Linking...$(OBJECTS)"
	@$(CPP) -o $(BIN_DIR)$(EXE_NAME) $(OBJECTS) $(SOURCE_DIR)main.cpp $(CPPFLAGS) -Wall 

run:
	./bin/$(EXE_NAME) 

#---------------------------------------------------------------------------------------------------------
clean:
	@echo "🧹 just some house keeping..."
	@rm -r $(BIN_DIR)* $(OBJECT_DIR)*