--IFT1227: Devoir 4
--Auteur: Lenny SIEMENI, Matricule: 1055234
library IEEE; use IEEE.STD_LOGIC_1164.all;
use ieee.NUMERIC_STD.all;

entity mux4 is -- four-input multiplexer
	generic (width: integer);
	port (d0, d1, d2: in STD_LOGIC_VECTOR(width-1 downto 0);
			s: in STD_LOGIC_VECTOR(1 downto 0);
			y: out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture behaviour of mux4 is
begin
  process(d0, d1, d2, s) is 
  begin
    if(s="00")then
      y <= d0;
    elsif(s="01")then
      y <= d1;
    elsif(s="10")then
      y <= d2;
    elsif(s="11")then
      y <= STD_LOGIC_VECTOR(to_unsigned(0,d0'length));
    end if;
  end process;
end behaviour;

