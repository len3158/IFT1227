-- Auteurs: Lenny SIEMENI, Julien KIANG
-- classe principale de l'automate cyclique
library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.numeric_std.all;

entity devoir_2_ii_c is 
	port(clk, reset_n: in STD_LOGIC;
		  y:			  out STD_LOGIC_VECTOR(4 downto 0));
end;

--Notre FSM
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
	process(state)begin
		case state is
			when S0 => nextstate <= S1;
			when S1 => nextstate <= S2;
			when S2 => nextstate <= S3;
			when S3 => nextstate <= S4;
			when S4 => nextstate <= S5;
			when S5 => nextstate <= S6;
			when S6 => nextstate <= S7;
			when S7 => nextstate <= S8;
			when S8 => nextstate <= S9;
			when S9 => nextstate <= S10;
			when S10 => nextstate <= S11;
			when S11 => nextstate <= S12;
			when S12 => nextstate <= S13;
			when S13 => nextstate <= S14;
			when S14 => nextstate <= S15;
			when S15 => nextstate <= S16;
			when S16 => nextstate <= S17;
			when S17 => nextstate <= S18;
			when S18 => nextstate <= S19;
			when S19 => nextstate <= S20;
			when S20 => nextstate <= S21;
			when S21 => nextstate <= S22;
			when S22 => nextstate <= S23;
			when S23 => nextstate <= S24;
			when S24 => nextstate <= S25;
			when S25 => nextstate <= S26;
			when S26 => nextstate <= S27;
			when S27 => nextstate <= S28;
			when S28 => nextstate <= S29;
			when S29 => nextstate <= S30;
			when S30 => nextstate <= S31;
			when S31 => nextstate <= S0;
			when others => nextstate <= S0;
		end case;
	end process;
				  
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