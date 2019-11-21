###################################IFT1227-Devoir 3###################################
# Auteurs: Lenny SIEMENI, Matricule: 1055234, courriel: lenny-joseph@umontreal.ca    #
#	   Julien KIANG,  Matricule: 20103932, courriel: julien.kiang@umontreal.ca   #
#										     #
# Ce programme permet de lire un texte entré par l'usage, l'afficher, le découper en #
# mots et de trier chaque mot en ordre alphabétique.				     #
#										     #
######################################################################################

#segment de la mémoire contenant les données globales
.data 


#messages d'usage pour l'utilisateur
msg1:.asciiz "Vous avez saisit le texte suivant:\n"
msg2:.asciiz "Tableau de mots non trié:\n"
msg3:.asciiz "Tableau de mots trié:\n"
msg4:.asciiz "Vous pouvez saisir 300 characères au maximum.\n"
msg5:.asciiz "Veuillez saisir du texte\n"
newline:.asciiz "\n"
tab:.asciiz "\t"

#tampon résérvé pour le texte
buffer:   .space    300	# allocate 300 consecutive bytes storgae non initialized
tabMots : .word    150 # allocate 150 words storage non initialized


#segment de la mémoire contenant le code
.text
.globl main

#$s0 = longueur chaine en octet, $s1 = tabMots, $s2 = tabMots.length()/nb Mots buffer, $7 = save return address in main
#$t0 = buffer, $t1 = adresse tabMots[i], $t2 = index, $t3 = , $t4 = saves return address in fonctions ,$t8 = compteur, $t9 = tempBuffer
main:
	jal 	saisir
	move 	$s7, $v0
	beqz 	$s0, erreur_vide 		#si le texte est vide on decide de ne rien faire
	move 	$s0, $v0
	bgt 	$s0, 300, erreur_size  		#si la chaine est plus longue que sepcifie
	
	la 	$a0, msg1
	li 	$v0, 4	   			#Afficher msg1 "Vous avez saisit le texte suivant"
	syscall
	la 	$a0, buffer 			#on recharge le tampon en argument
	jal 	print				#Affichage tel que demande
	
	la 	$a0, buffer($0)			#recharger le buffer en argument0
	la 	$a1, ($s0)			#taille de la chaine en argument1
	jal 	decMots
	
	la 	$a0, msg2
	li 	$v0, 4	  	 		#Afficher msg2 "Tableau de mots non trié"
	syscall
	
	li 		$a2, 0
	la 		$a1, tabMots($0)	#Argument tabMots
	add 	$a2, $a2, $s0			#Argument taille
	jal 	afficher			#Affichage selon tabMots
	
	la 	$a0, newline
	li 	$v0, 4	   			#Afficher nouvelle ligne
	syscall
	
	la 	$a0, msg3
	li 	$v0, 4	   			#Afficher msg3 "Tableau de mots trie"
	syscall
	
	li 	$a0, 0
	li 	$a1, 0
	la 	$a0, tabMots($0) 		#Adresse tabMots
	addi 	$a1, $s2, 0			#$a1 = tabMots.length()
	jal 	trier
	
	li 	$a2, 0
	la 	$a1, tabMots($0)		#Argument tabMots
	add 	$a2, $a2, $s0			#$a1 = tabMots.length()
	jal 	afficher			#Affichage selon tabMots
	
	li 	$v0, 10    				#terminer le programme
    	syscall

#Fonction saisir
saisir: 
	la 	$a0, buffer 				#load byte space into address
	li 	$a1, 300				# Set la limite de la longueur de la chaine (300 char)
	li 	$v0, 8					# Lire la chaine de char dans $v0 (Code 8 de syscall)
	syscall
	li 	$t8, 0 					# initialise le compteur a zero
	boucle:
		lb 	$t9, 0($a0) 			# load the next character into t9
		beqz 	$t9, Done_saisir 		# check for the null character
		addi 	$a0, $a0, 1 			# increment the string pointer
		addi 	$t8, $t8, 1			#increment chain size counter byte by byte
	j boucle 		
	Done_saisir:
		add 	$t8, $t8, -1			# strlength-1 pour ne pas compter \0 de fin
		move 	$v0, $t8 			#sauver la taille du texte en octet
		move 	$s0, $v0			#return taille texte en octet
		jr 	$ra
	
#Fonction print - Affiche comme demande
# $a0 = String pointer
#t2 = outilise comme backup, t8 = iterateur, t9 = contient un caractère du buffer
print:	
	li 	$t8, 0	    				#iterateur
	loop_print:
		lb  	$t9, 0($a0)		
		beqz 	$t9, Done			#Si EOS - > Done
		beq 	$t9, 92, isEnter		#charAt[i] = '\' (0x92) peut etre un '\n'
	continue:
		li 	$t2, 0				#reset $t2
    		move 	$t2, $a0			#Backup contenu de $a0
    		move 	$a0, $t9
		li 	$v0, 11				#Code 11 pour imprimer char par char
		syscall
		move 	$a0, $t2			#restaurer la valeur de $
		addi 	$a0, $a0, 1 			# increment the string pointer
		j 	loop_print		
	isEnter:
		addi 	$a0, $a0, 1			#on cherche juste apres le '\'
		lb  	$t9, 0($a0)
		beqz 	$t9, Done			#Si c'est en fait '\0' -> done
		beq 	$t9, 110, new_line		#Si c'est bien '\n' -> retour a la ligne
		addi 	$a0, $a0, -1			#Si non reconnu, on continue en reprenant a charAt[i-1]
		j 	continue		
	Done:	
		jr 	$ra
	new_line:
    		li 	$t2, 0					#reset $t2
   		move 	$t2, $a0				#Backup contenu de $a0
    		la      $a0, newline			#charger '\n' en argument
    		li      $v0, 4					#afficher
    		syscall
    		move 	$a0, $t2				#restaurer la valeur de $a0
    		addi 	$t9, $t9, 1				#incrementer pointeur chaine
    		j loop_print
    
#Fonction decMots
# $a0 = String pointer
#t7 = offset pour le tableau, t8 = compteur de mots, t9 = contient un caractère du buffer
#s2 = nb mots dans le buffer
decMots:
	#Set registers and return address
	move 	$s7, $ra
	li 	$t8, 0
	li 	$t7, 0
	lb 	$t9, 0($a0)
	move 	$a3, $t9
	jal 	lettre
	move 	$t4, $v0
	beq 	$t4, 1, sauver_mot		#sauve le premier char du buffer si c'est une lettre 
	loop_:
		lb 	$t9, 0($a0)
		beq 	$t9, '\n',remove_n			#si le pointeur dans la chaine arrive sur '\n' -> on remplace par null -> Done
		beqz 	$t9, check_done				#si le pointeur dans la chaine arrive sur '\o' -> Done
		beq 	$t9, 0x20, decouper_sauver		#Si on arrive a un espace, on a lu un mot, on le decoupe
		beq  	$t9, 92, isEnter_1			#si le pointeur arrive sur un '\'
		move  	$a3, $t9				#charger char en argument pour check si lettre 
		jal 	lettre
		move 	$t4, $v0
		beqz 	$t4, check_next				#si le pointeur dans la chaine arrive sur un char non lettre -> check suivant
		beq  	$t4, 1, incremente_string_pointer
	decouper_sauver:					#coming from space
		sb	$0, 0($a0)				#insère un \0 au byte x dans le buffer
		addi 	$a0, $a0, 1			#i++
	sauver_mot:					#coming from is enter only
		lb 	$t9, 0($a0)			
		beqz 	$t9, check_done			#if null
		sw 	$a0, tabMots($t7)		# sauver le char dans le tableau
		addi  	$t7,$t7,4			# offset = offset + 4
		addi    $t8,$t8,1      			# Incremente word count i = i+1
	incremente_string_pointer: 			#coming from loop
		addi 	$a0, $a0, 1
		j 	loop_
	check_next:					#char read is not letter
		sb	$0, 0($a0)			#insert null at this position
	loop_check_next:
		addi 	$a0, $a0, 1			#i++
		lb 	$t9, 0($a0)			#checking next
		beqz 	$t9, done_decMots		#if null -> done
		move  	$a3, $t9			#charger char en argument pour check si lettre 
		jal 	lettre				
		move 	$t4, $v0			
		beq 	$t4, 0, loop_check_next		#if not letter keep looping
		j 	sauver_mot 			#else save new word and resume
	check_done:
		addi 	$a0, $a0, 1		#i++
		lb 	$t9, 0($a0)
		beqz 	$t9, done_decMots	#if null -> done
		addi 	$a0, $a0, -1		#else
		j	loop_			# jump back to loop_
	remove_n:
		sb	$0, 0($a0)		#insert null a la place de '\n'
		j 	check_done	
	isEnter_1:
		addi 	$a0, $a0, 1		#on cherche juste apres le '\'
		lb  	$t9, 0($a0)
		beq 	$t9, 110, continue_isEnter1		#Si c'est bien '\n' -> mettre null sur \ -> sauver apres n
		addi 	$a0, $a0, -1		#sinon->rollback decouper et sauver normalement
	continue_isEnter1:
		addi 	$a0, $a0, -1		#rollback
		sb	$0, 0($a0)		#insère un \0 au byte x dans le buffer
		addi 	$a0, $a0, 2		#juste apres n
		j 	sauver_mot
	done_decMots:
		addi 	$t8, $t8, 1		#On a lu le dernier mot fin de chaine
		addi 	$s2,$t8,0		#Sauvegarder le nombre de mots dans la chaine
		move 	$ra, $s7		#restoring in main return address
		jr 	$ra	

#Fonction afficher:
#t3, t4, t5, t6, t7, t8 ,t9, a0, a1, v0, t5 
afficher:
	move 	$s7, $ra			#saving return address to main
    	li    	$t7,0      			# offset = 0 au depart
   	addi	$t6, $0, 0    			# temp for tabMots.length
   	li	$t8, 0    			#word count
   	li	$t4, 0	      			#compteur affichage
   	li 	$a3, 0	      			#boolean is lettre
	lw 	$t5, 0($a1)	     		#charger le premier byte depuis tabMots
	loop_afficher:
		beq	$t8, $a2, done_afficher #word count = strlength()
		beqz 	$t5, done_afficher	#null character
		lb 	$t9, 0($t5) 
		beqz 	$t9, fin_mot
		beq 	$t9, 0x92, isEnter_2
		addi 	$a3, $t9, 0
		jal 	lettre			#if not lettre
		move 	$t3, $v0		
		beq 	$t3, 0, continuer_afficher	#skip affichage
		move 	$a0, $t9
		li 	$v0, 11			#Code 11 pour imprimer char par char
		syscall
	continuer_afficher:
   		addi	$t6,$t6,1	   	#tabMots.length+1
   		addi    $t5,$t5,1           	# advance pointer on current string
   		li 	$t3, 1
    		j     	loop_afficher
	newline_afficher:
		la      $a0, newline
    		li      $v0, 4
    		syscall
    		li 	$t4, 0
    		j	loop_afficher
	fin_mot:
		la 	$a0, tab			#inserer tabulation
		li 	$v0, 4
   		syscall
		li 	$t5,0
		addi    $a1,$a1,4          	 	# advance tabMots index
		lw 		$t5, 0($a1)		#recharger le mot suivant a la nouvelle adresse
		addi 	$t8, $t8, 1			#word count++
		addi	$t4, $t4, 1			#compteur+1
		beq		$t4,4, newline_afficher
		j 		loop_afficher
	isEnter_2:
		addi 	$t5, $t5, 1			#on cherche juste apres le '\'
		lb  	$t9, 0($t5)
		beq 	$t9, 110, continuer_afficher	#Si c'est bien '\n' -> skip
		addi 	$t5, $t5, -1			#Si non reconnu, on reprend a charAt[i-1]
		j 		continuer_afficher
	done_afficher:
		move 	$s2, $t6			#sauvegarder tabMots.length()
		move 	$ra, $s7			#restoring in main return address
		jr 		$ra

#Fonction Trier
#a0 = tabMots, a1 = tabMots.length
#t1, t5 = iterateur tabMots, $t3 = tempSwap, t4 = boleen, t6 = compteur
trier:	
	li 	$t6, 0					#loop counter
	j 	loop_trier
	reset_registre:
		li 	$t1, 4				#i+1
		li 	$t5, 0				#i
		li 	$t4, 0 				#will hold true ou false selon la comparaison
		addi 	$t6, $t6, 1			#loop counter++
	loop_trier:
		beq 	$t6, $a1, done_trier
		lw 		$t8, tabMots($t5) 	#tabMots[i]
		lw 		$t9, tabMots($t1) 	#tabMots[i+1]
		beqz 	$t9, reset_registre 		#prevent index out of range tabMot[i+1]
		move 	$a2, $t8			#charger tabMots[i] en argument
		move 	$a3 , $t9			#charger tabMots[i+1] en argument
		j 	strCmp
	continue_trier:
		addi 	$t5, $t5, 4			#tabMots[i+1]
		addi 	$t1, $t1, 4			#tabMots[i+1+1]
		li 	$t4, -1				#reset $t4 to default : non trié
		j 	loop_trier
	swap:
		sw 	$t8, tabMots($t1)		#tabMots[i] = tabMots[i+1] 
		sw 	$t9, tabMots($t5)		#tabMots[i+1] = tabMots[i]
		j 	continue_trier
	done_trier:
		jr 		$ra

#Fonction strCmp -1 = i<i+1, 0 i=i+1, 1 = i>i+1
strCmp: 
	lb      $t2,($a2)			# charger la valeur en byte du char dans str1
    	lb      $t3, ($a3)			# charger la valeur en byte du char dans str2
    	beqz 	$t2, continue_trier	    	#si str1 ou str2 point sur null, on est arrive a la fin d'une chaine
	beqz	$t3, continue_trier
	beq 	$t2, $t3, eq		    	#$t4 = 0 si $t2 (str1) = $t3 (str2)
	blt  	$t2, $t3, lt		    	#t$4 = -1 si $t2 (str1) < $t3 (str2)
	bgt	$t2, $t3, gt		   	 #t$4 = 1 si $t2 (str1) > $t3 (str2)
	continue_strCmp:
		beq 	$t4, 1,swap
		beq	$t4, -1, continue_trier
    		addi    $a2,$a2,1			# pointer vers le char suivant de str1
    		addi    $a3,$a3,1			# pointer vers le char suivant de str2
    		j       strCmp
	eq:
		move 	$t4,$0				#return 0
		j continue_strCmp
	lt:
		move 	$t4,$0
		addi 	$t4, $t4, -1			#return -1
		j continue_strCmp
	gt:
		move 	$t4,$0
		addi 	$t4, $t4, 1			#return 1
		j continue_strCmp 
  
#Fonction lettre
#$a3 = contient un char du buffer, $v0 = booleen
lettre:
	blt 	$a3, 0x40, false		#Si $a3 est au-dessous de 7A, pas une lettre
	bgt 	$a3, 0x7B, false		#Si $a3 est au-dessus de 7A, pas une lettre
	blt   	$a3, 0x5B, true			#$v0 = 1 si 41 > $a3 (char) < 5A
	bgt  	$a3, 0x60, true			#$v0 = 1 si 61 > $a3 (char) < 7A
	move 	$v0, $0				#Sinon char pas une lettre
	jr 	$ra				#return
	true:
		move 	$v0, $1
		jr 	$ra			#return true 1
	false:
		move 	$v0, $0		
		jr 	$ra			#return false 0

erreur_size:
	la 	$a0, msg4				# Afficher msg d'erreur msg4
	li 	$v0, 4					# Print string (Code 4 de syscall)
	syscall
	li 	$v0, 10    				# Terminer le programme
    	syscall

erreur_vide:
	la	$a0, msg5				# Afficher msg d'erreur msg5 (vide)
	li 	$v0,4					# Print string (Code 4 de syscall)
	syscall
	li	$v0,10					# Terminer le programme
	syscall
