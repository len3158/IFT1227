library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.numeric_std.all;

entity devoir_2_ii_c is 
	port(clk, reset_n: in STD_LOGIC;
		  y:			  out STD_LOGIC_VECTOR(4 downto 0));
end;

architecture synth of devoir_2_ii_c is
	type statetype is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11,
							S12, S13, S14, S15, S16, S17, S18, S19, S20, S21,
							S22, S23, S24, S25, S26, S27, S28, S29, S30, S31);
	signal state, nextstate: statetype;
	begin
	-- Logique combinatoire de l'etat courant
	process(clk, reset_n)begin
		if reset_n = '0' then state <= S0;
		elsif clk'event and clk = '1' then
			state <= nextstate;
		end if;
	end process;
	
	--Logique combinatoire de l'etat suivant
	nextstate <= S1 when state = S0 else
				  S2 when state = S1 else
				  S3 when state = S2 else
				  S4 when state = S3 else
				  S5 when state = S4 else
				  S6 when state = S5 else
				  S7 when state = S6 else
				  S8 when state = S7 else
				  S9 when state = S8 else
				  S10 when state = S9 else
				  S11 when state = S10 else
				  S12 when state = S11 else
				  S13 when state = S12 else
				  S14 when state = S13 else
				  S15 when state = S14 else
				  S16 when state = S15 else
				  S17 when state = S16 else
				  S18 when state = S17 else
				  S19 when state = S18 else
				  S20 when state = S19 else
				  S21 when state = S20 else
				  S22 when state = S21 else
				  S23 when state = S22 else
				  S24 when state = S23 else
				  S25 when state = S24 else
				  S26 when state = S25 else
				  S27 when state = S26 else
				  S28 when state = S27 else
				  S29 when state = S28 else
				  S30 when state = S29 else
				  S31 when state = S30 else
				  S0 when state = S31;
				  
	-- Logique combinatoire de la sortie Y
	y <= "10000" when state = S0 else
		  "10001" when state = S1 else
		  "10010" when state = S2 else
		  "10011" when state = S3 else
		  "10100" when state = S4 else
		  "10101" when state = S5 else
		  "10110" when state = S6 else
		  "10111" when state = S7 else
		  "11000" when state = S8 else
		  "11001" when state = S9 else
		  "11010" when state = S10 else
		  "11011" when state = S11 else
		  "11100" when state = S12 else
		  "11101" when state = S13 else
		  "11110" when state = S14 else
		  "11111" when state = S15 else
		  "00000" when state = S16 else
		  "00001" when state = S17 else
		  "00010" when state = S18 else
		  "00011" when state = S19 else
		  "00100" when state = S20 else
		  "00101" when state = S21 else
		  "00110" when state = S22 else
		  "00111" when state = S23 else
		  "01000" when state = S24 else
		  "01001" when state = S25 else
		  "01010" when state = S26 else
		  "01011" when state = S27 else
		  "01100" when state = S28 else
		  "01101" when state = S29 else
		  "01110" when state = S30 else
		  "01111" when state = S31;
end;