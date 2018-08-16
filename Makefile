ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

NAME =			libft_malloc_$(HOSTTYPE).so

LINK =			libft_malloc.so

CC =			gcc

FLAGS =			-Wall -Werror -Wextra

HEADERS =		-I ./inc

SRC_DIR =		./src/

OBJ_DIR_NAME =	obj
OBJ_DIR =		./obj/

FILENAMES =		free malloc realloc show_alloc_mem

OBJ_PATHS :=	$(addsuffix .o,$(FILENAMES))
OBJ_PATHS :=	$(addprefix $(OBJ_DIR),$(OBJ_PATHS))

all: $(NAME)

$(NAME): $(OBJ_PATHS)
	$(CC) $(OBJ_PATHS) $(HEADERS) -shared -o $(NAME)
	@/bin/rm -f $(LINK)
	ln -s $(NAME) $(LINK)

$(OBJ_PATHS): $(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@/bin/mkdir -p $(OBJ_DIR)
	$(CC) -c $(FLAGS) $(HEADERS) $< -o $@

clean:
	-/bin/rm -f $(OBJ_PATHS)
	/usr/bin/find . -name "$(OBJ_DIR_NAME)" -maxdepth 1 -type d -empty -delete

fclean: clean
	-/bin/rm -f $(NAME) $(LINK)

re: fclean all
