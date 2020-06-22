Matei Alexandru-Petrut
323AC
		     ==================== TEMA 1 - MN ===========================

	Vreau sa specific faptul ca am trimis tema pe VM checker V2, dar nu as vrea sa se ia 
	acea tema pentru ca aveam mai putine puncte si nu am mai apucat apoi sa o trimit pe
	VM checker pentru ca s-a blocat site-ul.

	De asemenea, vreau sa specific faptul ca am avut 90 de puncte de cand am trimis-o prima
	data pe VM checker V2 (a se consulta site-ul). Sper sa nu fie o problema
	si am vrut sa se stie ca am avut 90 de puncte de acum o saptamana (atat am si acum).
	Am testat si checker-ul mi-a acordat cele 90 puncte pe masina virtuala.
	
	Task 1 (Sparse Jacobi):
		
	- am implementat functia generate_probabilities_system astfel: 

		- m-am gandit sa impart matricea A in 4 si sa o populez cu valori
		  astfel incat in partea dreapta superioara sa am matricea la pasul
		  anterior, in partea dreapta inferioara pe "diagonalele secundare"
		  (deasupra si sub diagonala principala) sa pun doar -1, iar in partile
		  superioara dreapta si inferioara stanga sa o populez dupa o anumita 
		  regula, tinand cont de faptul ca matricea A e matrice simetrica

		- daca am reusit sa populez partea dreapta superioara, atunci la fel va 
		  arata si partea stanga inferioara pentru ca e matrice simetrica

		- populez partea superioara dreapta tinand cont de cum se modifica de
		  fiecare data ultimul rand al labirintului

		- am gasit regula pentru vectorul b, acesta trebuie sa aiba pe primele
		  (nr. linii matrice A - rows) linii numai 0 si pe urmatoarele rows linii
		  numai 1

		- implementarea este explicata mai in detaliu in comentariile din cod

	- am implementat functia matrix_to_csr astfel: 

		- am parcurs matricea A si am pus toate elementele nenule in vectorul
		  values

		- am pus in vectorul colind toti indicii de coloana ale elementelor puse
		  mai sus in values, in aceeasi ordine (sincronizez cele 2 iteratii)
		
		- am pus in vectorul rowptr pe primele n pozitii doar indicii elementelor
		  din values care sunt cap de linie pentru A si pe ultima pozitie am pus
		  (numarul de elemente al lui values + 1)

	- am implementat functia Jacobi_factorization astfel:
		
		- am creat o matrice diagonala dupa A, D
		
		- am creat o matrice care contine opusul elementelor lui A si numai zerouri
		  pe diagonala principala, P

		- am obtinut inversa matricei diagonale, inv_D
	
		- matricea de iteratie va fi inv_D * P

		- vectorul de iteratie va fi inv_D * b

	- am implementat functia Jacobi_sparse astfel:

		- am calculat numarul de elemente care contin indicii primelor 
		  elemente de pe fiecare rand ale matricei de iteratie
	
		- am initializat solutia sistemului cu vectorul nul
		
		- am calculat x conform formulei folosind functia csr_multiplication
		  pana cand iteratiile se afla sub toleranta, adica eroarea e mai mica
		  decat toleranta, unde eroarea este diferenta dintre noul x calculat
		  si vechiul x
		
		- am setat si un numar maxim de pasi sub care am observat ca iteratiile
		  ajung sub toleranta

		- cand iteratiile se gasesc sub toleranta, returnez solutia x

	Task 2 (K-Means):
	
	- am implementat functia clustering_pc astfel:
		
		- am initializat centroizii conform algoritmului din cerinta: creez NC
		  clustere si NC centroizi corespunzatori, fiecare cluster va contine
		  n / NC puncte, unde n e numarul de puncte din multimea initiala de puncte
		  cu dims dimensiuni; calculez fiecare centroid ca fiind media arimetica
		  a tuturor punctelor din fiecare cluster creat, pe dimensiuni

		- am facut algoritmul de stabilizare al centroizilor: while-ul cicleaza 
		  pana cand centroizii se stabilizeaza, calculez distanta minima dintre 
	          centroid si celelalte puncte folosind norm, adaug punctul in grupul i, 
		  unde i ia valori de la 1 la dims, fac suma fiecarei coordonate a punctelor
		  din jurul fiecarui centroid, aflu noul centroid (centrul de masa) prin
 		  impartirea sumei determinate la numarul de elemente din fiecare grup

		- cand centroizii s-au stabilizat (cei anteriori sunt egali cu cei noi
		  calculati) while-ul se opreste si obtin vectorul centroids cerut

	- am implementat functia compute_cost_pc astfel:

		- initializez costul total cu 0 

		- retin numarul de puncte si centroizi

		- parcurg si punctele si centroizii si calculez cu norm distanta dintre
		  fiecare punct si toti centroizii

		- de fiecare data retin distanta minima dintre punct si centroizi, fiind
		  initializata cu distanta dintre punct si primul centroid

		- adaug la finalul parcurgerii centroizilor distanta minima corespunzatoare
		  fiecarui punct la costul total

	Task 3 (Householder prediction):
		
	- am implementat functia rgbHistogram astfel:
		
		- am citit imaginea de la calea specificata in antetul functiei

		- am obtinut fiecare componenta R,G,B (matricea imaginii e pe 3 "dimensiuni")

		- am initializat niste indici pentru fiecare componenta in parte (R,G,B)

		- am initializat histograma cu zerouri, fiind un vector linie cu 
		  3 * count_bins coloane

		- completez elementele vectorului sol parcurgand fiecare componenta in parte,
		  verificand daca se afla in fiecare din cele count_bins intervale create
		  dupa formula din cerinta 
	
	- am implementat functia transform_rgb_to_hsv astfel:
		
		- am citit imaginea de la calea specificata in antetul functiei

		- am obtinut fiecare componenta R,G,B (matricea imaginii e pe 3 "dimensiuni")
	
		- parcurg fiecare componenta R,G,B si aplic algoritmul din cerinta (scaland
		  fiecare element al R,G,B la intervalul [0,1]) si obtin elementele 
		  componentelor H,S,V corespunzatoare celor din R,G,B

		- elementele de pe linia i si coloana j din R,G,B vor avea corespodent
		  pe elementele de pe linia i si coloana j din H,S,V
	
		- functia e o replica la rgb2hsv implementata in Octave

	- am implementat functia hsvHistogram astfel:
		
		- retin componentele H,S,V apeland functia transform_rgb_to_hsv

		- am initializat niste indici pentru fiecare componenta in parte (H,S,V)

		- am initializat histograma cu zerouri, fiind un vector linie cu 
		  3 * count_bins coloane

		- completez elementele vectorului sol parcurgand fiecare componenta in parte,
		  verificand daca se afla in fiecare din cele count_bins intervale create
		  dupa formula din cerinta (acum am intervalul [0,1] pe care il impart la
		  1.01 -> analogie cu rgbHistrogram, unde intervalul era [0,255] si imparteam
		  la 256)

	Probleme si observatii:

	- am avut ceva probleme la implementare legate de timpul de executie, obtin timpi
	  care se afla in intervalele specificate in tema, insa dificultatea a fost in 
	  incapacitatea de a face vectorizari; nu prea am inteles cum se fac exact cand
	  am mai multe conditii si parcurg matrici pe linii sau coloane etc.	

	- teoretic, eu cred ca ma descurcam sa duc pana la capat tema, adica sa fac si partea
	  de obtinere a procentajului la task-ul 3 si sa fac si task-ul 4 care era asemanator
	  cu 3, insa nu ma incadram deloc in timp cu functia preprocess si deci imi luam timeout
	  daca alegeam sa introduc in sursele trimise si celelalte functii pe care le-am facut
	  (learn si evaluate de la task 3 si task 4)

	- am incercat sa fac la rgbHistogram si hsvHistogram cu histc dar obtineam o valoare, 
	  2 eronate pentru ca citez : "functia histc exclude in intervalul i elementul i+1" si
	  sincer sa fiu nu prea am inteles formularea, nici nu mi-a explicat-o cineva, desi
	  am cerut ajutor in cadrul echipei de MN (nu mi s-a raspuns pe forum)
	
	- deci ca feedback: incercati sa acordati punctaje intermediare prin corectare 
	  manuala pe task-uri care dau timeout pentru ca eu consider ca de multe ori
	  conteaza si logica din spatele programului (sunt de acord ca si eficientizarea codului
	  e importanta)

	- per total, in tema iti putea lua ceva timp sa rezolvi probleme de logica (gen, aici
	  trebuie sa fac urmatorul cast ca sa mearga, sau trebuie sa iau in calcul ca functia
	  X face si urmatorul lucru - ca la histc); nu scriai prea mult cod, dar nu asta e 
	  relevant, pe alte chestii se pierdea timpul

	- imi place ideea de teme pe task-uri, consider ca asa se pot acorda punctaje
	  intermediare pe teme, nu toata lumea e capabila sa faca o tema cap coada (exista
	  teme la care iei 0 (sau o valoare infima) ori maxim -> astea nu sunt o idee buna 

		