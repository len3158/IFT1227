-- Auteurs: Lenny SIEMENI, Julien KIANG
-- classe principale afficheur DCB 5 bits en description structurelle
-- hex0: unites, hex1: dizaines, hex2: signe + ou -
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity devoir_2_iii is
	port(clk, reset_n: in STD_LOGIC;
		  hex2: out STD_LOGIC_VECTOR(6 downto 0);
		  hex1: out STD_LOGIC_VECTOR(6 downto 0);
		  hex0: out STD_LOGIC_VECTOR(6 downto 0));
end;

--Le modele structurel compose du generateur et convertisseur
architecture struct of devoir_2_iii is

--Le generateur de sequence cyclique
	component devoir_2_ii_c
		port(clk, reset_n: in STD_LOGIC;
				y:			    out STD_LOGIC_VECTOR(4 downto 0));
	end component;

--Le convertisseur vers les 7 segments display
	component Devoir_2_q2
		port(d: in STD_LOGIC_VECTOR(4 downto 0);
		  hex2: out STD_LOGIC_VECTOR(6 downto 0);
		  hex1: out STD_LOGIC_VECTOR(6 downto 0);
		  hex0: out STD_LOGIC_VECTOR(6 downto 0));
	end component;


	signal y: STD_LOGIC_VECTOR(4 downto 0);
	begin
		generateur: devoir_2_ii_c port map(clk,reset_n,y);
		convertisseur: devoir_2_q2 port map(y, hex2, hex1, hex0);
end;