#import <AVFoundation/AVFoundation.h>
#include <fstream>
#include <ncurses.h>
#include <unistd.h>
#include "util.h"

AVAudioPlayer *player;

void initialize() {
    initscr();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE);
}

void exit() {
    endscr();
}

rect getScreenDimensions() {
    rect retval;
    retval.width = COLUMNS;
    retval.height = LINES;
    return retval;
}

void print(std::string text) {
    waddstr(stdscr, text.c_str());
}

void printScreen(std::vector<std::vector<Block> > blockmap, char[4][4] icon) {
    
}

keypress getkey() {
    int ch = getch();
    if (ch == KEY_UP) return KEY_PRESSED_UP;
    else if (ch == KEY_DOWN) return KEY_PRESSED_DOWN;
    else if (ch == KEY_LEFT) return KEY_PRESSED_LEFT;
    else if (ch == KEY_RIGHT) return KEY_PRESSED_RIGHT;
    else if (ch == KEY_ENTER) return KEY_PRESSED_SELECT;
    else if (ch == KEY_BACKSPACE) return KEY_EDIT_DELETE;
    else if (ch == ' ') return KEY_PRESSED_JUMP;
    else if (ch == 27) return KEY_PRESSED_BACK;
    else if (ch == 'c') return KEY_PRESSED_ICONCHANGE;
    else if (ch == 'e') return KEY_EDIT_LEVEL;
    else if (ch == 9) return KEY_EDIT_CHANGE;
    else return KEY_PRESSED_NONE;
}

void playAudio(audio buf) {
    player = [[AVAudioPlayer alloc] initWithData:[[NSData alloc] initWithBytes:buf.data length:buf.len] error:NULL];
    [player play];
}

void stopAudio() {
    [player stop];
}

std::string readFile(std::string file) {
    std::ifstream in;
    in.open(file.c_str());
    std::string retval, line;
    while (std::getline(in, line)) retval += line + "\n";
    in.close();
    return retval;
}

void writeFile(std::string file, std::string text) {
    std::ofstream out;
    out.open(file.c_str());
    out << text;
    out.close();
}
