//Byond type ids
#define TYPEID_NULL "0"
#define TYPEID_NORMAL_LIST "f"
//helper macros
<<<<<<< HEAD
#define GET_TYPEID(ref) ( ( (length(ref) <= 10) ? "TYPEID_NULL" : copytext_char(ref, 4, length(ref)-6) ) )
#define IS_NORMAL_LIST(L) (GET_TYPEID("\ref[L]") == TYPEID_NORMAL_LIST)
=======
#define GET_TYPEID(ref) ( ( (length(ref) <= 10) ? "TYPEID_NULL" : copytext(ref, 4, length(ref)-6) ) )
#define IS_NORMAL_LIST(L) (GET_TYPEID(text_ref(L)) == TYPEID_NORMAL_LIST)
>>>>>>> 0bf2ecb8c04103f5e82fb25aeefd8282c223c45c


