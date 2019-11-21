--IFT1227: Devoir 4
--Auteur: Lenny SIEMENI, Matricule: 1055234
library IEEE; use IEEE.STD_LOGIC_1164.all;
--used by andi, ori et lui
entity zeroExtend is -- zero extender
	port(	a: in STD_LOGIC_VECTOR (15 downto 0);
			y: out STD_LOGIC_VECTOR (31 downto 0));
end;

architecture behave of zeroExtend is
begin
	y <= X"0000" & a;
end;
