/******************************************************************************
 * NE PAS MODIFIER CE FICHIER
 *
 * Structures utilisees dans le programme
 *
 ******************************************************************************/

#pragma once
#include <cstdint>
#include <string>

/******************************************************************************/

struct Pixel {
    uint8_t b;
    uint8_t g;
    uint8_t r;
    uint8_t a;  // le canal alpha n'est pas utilisé et ne sert que comme padding pour aligner Pixel sur 4 octets.
                // Sa valeur est de 0xFF par défaut.
};

/******************************************************************************/

struct Image {
    uint32_t largeur;
    uint32_t hauteur;
    Pixel** pixels;

    /******************************************************************************/
    // Vous pouvez ignorer les methodes ci-dessous
    // Rappel: les methodes ne comptent pas dans la taille d'une struct/classe
    // Elles servent a charger les images en memoire
    // Leurs implementations sont dans libTP3 et ne sont pas a comprendre ni utiles pour le TP
    Image() = default;
    Image(const Image& other);
    Image& operator=(const Image& other);
    ~Image();
    Image(const std::string& filename);
    void saveImage(const std::string& filename);
};