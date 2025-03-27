# Projekat iz Verifikacije Softvera


## Uvod

Ovaj projekat analizira i verifikuje implementaciju igre *The Legend of Zelda* u programskom jeziku C++ sa projekta dostupnog na GitHub-u na sledećoj adresi: [zelda](https://github.com/hecrj/zelda). 

Analiza je izvršena na grani: `master`  
Heš kod commit-a: `73cf1f211b3a28f7a0cbdf429503f9396276cd3c`

Cilj analize je poboljšanje stabilnosti i efikasnosti aplikacije korišćenjem statičkih i dinamičkih alata za analizu koda.  

## Izmena Projekta
Potrebno je postaviti working directory na putanju do projekta kako bi sve funkcionalnosti pravilno radile.

### Primena custom.patch:
- **cd Zelda**
- **git apply ../custom.patch**


## Instalacija alata

Za verifikaciju koda korišćeni su sledeći alati:

- **Cppcheck** – statička analiza koda
- **Clang-Tidy** – analiza kvaliteta i optimizacije C++ koda
- **Doxygen** – generisanje automatske dokumentacije
- **Valgrind Memcheck** – analiza memorije i otkrivanje curenja memorije
- **Valgrind Callgrind** – profilisanje performansi i analiza efikasnosti koda



## Instalacija alata

Pre pokretanja analize potrebno je instalirati sledeće alate:

```bash
sudo apt install cppcheck
sudo apt install clang-tidy
sudo apt install doxygen
sudo apt install valgrind
sudo apt install kcachegrind
```

## Korišćeni alati i analiza rezultata

### 1. Cppcheck

Pre pokretanja, pozicionirati se u direktorijum projekta:

```bash
cd ../cppcheck
```

Pokrenuti Cppcheck sledećom komandom:

```bash
cppcheck --project=compile_commands.json --enable=all --std=c++20 -inconclusive --report-progress &> cpp_check_res.txt
```

### 2. Clang-Tidy

Pre pokretanja, pozicionirati se u direktorijum projekta:

```bash
cd ../clang-tidy
```

Pokrenuti Clang-Tidy sledećom komandom:

```bash
run-clang-tidy -checks='clang-diagnostic-*, clang-analyzer-*' .. &> clang-tidy-report.txt
```

### 3. Doxygen

Pre pokretanja, pozicionirati se u direktorijum projekta:

```bash
cd ../doxygen
```

Dati skripti odgovarajuće dozvole i pokrenuti je:

```bash
chmod +x run_doxygen.sh
./generate_doxygen.sh
```

### 4. Valgrind Memcheck

Pre pokretanja, pozicionirati se u direktorijum projekta:

```bash
cd ../valgrind/memcheck
```

Dati skripti odgovarajuće dozvole i pokrenuti je:

```bash
chmod +x run_memcheck.sh
./run_memcheck.sh
```

### 5. Valgrind Callgrind

Pre pokretanja, pozicionirati se u direktorijum projekta:

```bash
cd ../valgrind/callgrind
```

Dati skripti odgovarajuće dozvole i pokrenuti je:

```bash
chmod +x run_callgrind.sh
./run_callgrind.sh
```

## Zaključak

Primena različitih alata za analizu koda omogućila je sveobuhvatnu proveru stabilnosti i efikasnosti aplikacije. Statičkom analizom pomoću **Cppcheck** i **Clang-Tidy** detektovane su sintaksičke greške, problemi sa memorijom i mogućnosti optimizacije koda. **Doxygen** je omogućio generisanje detaljne dokumentacije, olakšavajući razumevanje strukture projekta i njegovu dalju nadogradnju.

Dinamičkom analizom kroz **Valgrind Memcheck** identifikovani su problemi sa upravljanjem memorijom, poput curenja memorije i neoslobođenih alokacija, dok je **Valgrind Callgrind** omogućio uvid u performanse aplikacije, otkrivajući funkcije sa najvećim opterećenjem. Vizuelizacija podataka pomoću **KCacheGrind** pomogla je u identifikaciji uskih grla u izvršavanju koda.

Predložene optimizacije uključuju:
- **Bolje upravljanje memorijom** – smanjenje curenja i efikasnije oslobađanje resursa korišćenjem pametnih pokazivača (`std::unique_ptr`, `std::shared_ptr`).
- **Poboljšanje performansi** – optimizacija najčešće pozivanih funkcija, redukovanje broja realokacija memorije i efikasnije korišćenje STL kontejnera.
- **Unapređenje kodnog stila** – primena modernih C++ standarda, zamena zastarelih konstrukcija i optimizacija iteracija kroz strukture podataka.



