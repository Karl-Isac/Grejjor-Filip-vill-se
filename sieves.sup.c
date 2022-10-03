/*
 print-primes.c
 By David Broman.
 Last modified: 2015-09-15
 This file is in the public domain.
*/


#include <stdio.h>
#include <stdlib.h>

#define COLUMNS 6
int count = 0;

//void print_primes(int n){

    //int i;
    
    //int is_prime(int n);
    //int print_numbers(int n);
    //for (i = 2; i < n; i++){
        //if (is_prime(i) == 1){
            //print_numbers(i);
            //}}}


int print_numbers(int n){
printf("%10d", n);
++count;
int columns = 6;
if (count % columns == 0){
    printf("\n");
}
return 0;
}


void print_sieves(int n){
    
    int lista[n];
    int i;
    int k;
    int biggest = 0;
    int inte_klart = 1; //True
    
    for (i = 2; i <= n; ++i){  //Gör en lista med alla värden 2—n där 2 är på listplats 0
        lista[i-2] = i;
    }
    i = 0;
    while (inte_klart){
        if (lista[i] == 0){  //Om värdet är 0 så var det talet en produkt och nollades
            ++i;
        }
        else{
            biggest = i + 2;
            for (k = 2; k <= n / biggest; ++k){
                lista[biggest * k - 2] = 0;   //Nollar alla produkter av "biggest"
            }
            ++i;
            if (i >= n - 2){  //Avslutar while-satsen.
                inte_klart = 0; //false
            }
        }}
    int skill_sum = 0;
    int j = 0;
    int lilla_p;
    int stora_p;
    for (i = 0; i <= n - 2; ++i){
        if (lista[i] != 0){
            print_numbers(i+2);
            
            //suprise
            if (i > 1){
                stora_p = i + 2;    //primtalet över lilla_p
                skill_sum = skill_sum + (stora_p - lilla_p);
                lilla_p = i + 2;    //Det som var det större primtalet blir det                     mindre nästa omgång
                ++j;
            }
            else{
                lilla_p = i + 2; //Endast när i = 0 blir lilla_p det minsta                         primtalet (2)
            }
        
            
        }
    }
    printf("\n");
    printf("%10d", skill_sum/j);  //Printar suprise res avrundat ned
    printf("\n");
    }


int main(int argc, char *argv[]){
    print_sieves(50);
}
