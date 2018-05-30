#include <stdio.h>
int main(int argc, char* argv[])
{
	register int key;

	FILE *fp1, *fp2;
	fp1 = fopen("mult-clean.F90", "rb");
	fp2 = fopen("mult.F90", "wb");


    fprintf(fp2, "%s%s%s", "#define USE_DOT ", argv[1],"\n");
    fprintf(fp2, "%s%s%s", "#define USE_CACHE ", argv[2], "\n");
	while ((key = fgetc(fp1)) != EOF)
	 {
	 	fputc(key, fp2);
	 }
	fclose(fp1); fclose(fp2);

 return 0;
}


