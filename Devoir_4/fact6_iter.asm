main:
	addi 	$4, $0, 6		# Mettre $v0 en tant qu'une entree ($a0) $a0 = $v0 + 0
	jal fib_iter			# Copier l'adresse de sortie dans $ra et executer fib_iter
fib_iter:
	lui	$8, 0		# f(n) initialisee: $t0 = 1
	addi 	$9, $0, 0		# Mettre $t1 a 0 (x)
	addi 	$10, $0, 0		# Mettre $t2 a 0 (y)
	addi 	$11, $0, 1		# Mettre $t3 a 1 (z)
	addi 	$12, $0, 1		# Mettre $t4 a 1 (i)
loop:
	bge 	$12, $4, done		# Si $t4 >= a on termine (i) : la condition d'arret
	add	$9, $10, $11		# $t1 = $t2 + $t3
	add	$10, $11, $0		# $t2 = $t3
	add	$11, $9, $0		# $t3 = $t1
	addi	$12, $12, 1		# On incremente le i	
	j	loop			# On rappel la boucle
done:
	sw $9, 16($0)	#sauver le resultat a l'adresse Ox10 = 16 (low order of bytes)
	