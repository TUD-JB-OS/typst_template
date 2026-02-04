# Methode

## Experimentele Opstelling
Voor de metingen aan het eerste en tweede orde filter wordt gebruik gemaakt van het circuit zoals schematisch weergegeven in \numref{fig:opstelling}. Het eerste orde filter bestaat uit een weerstand $R_0 = 103.5 \pm 0.1 \mathrm{\Omega}$ en een condensator $C_0 = 3.42 \pm 0.08 \mathrm{\mu F}$. De spanning over de functiegenerator ($V_{in}$) en de uitgangspanning $V_{out}$ over de condensator worden met de oscilloscoop gemeten. In het tweede orde filter staat over de uitgang van het eerste filter met $R_1 = 103.5 \pm 0.1 \mathrm{\Omega}$ en $C_1 = 2.19 \pm 0.07 \mathrm{\mu F}$ een tweede filter met $R_2 = 100.3 \pm 0.1 \mathrm{\Omega}$ en $C_2 = 0.96 \pm 0.01 \mathrm{\mu F}$. De uitgangsspanning wordt dan over $C_2$ gemeten. 

Deze waarden voor $R_0$ en $C_0$ zijn zo gekozen dat de cut-off frequentie van het filter rond $1 \mathrm{kHz}$ ligt. De oscilloscoop en functiegenerator werken namelijk goed enkele ordes boven en onder deze frequentie. De waarden voor $R_1$, $R_2$, $C_1$ en $C_2$ zijn zo gekozen dat het systeem een vergelijkbare cut-off frequentie heeft als het eerste orde filter wat handig is voor het vergelijken van de twee filters.

Alle componenten kunnen ideaal worden beschouwd. De interne weerstand van de oscilloscoop is namelijk veel groter dan de impedantie van de condensator. Ook is de capaciteit van de BNC-kabels verwaarloosbaar ten opzichte van de gebruikte condensatoren. De weerstand van de bedrading is verwaarsloosbaar ten opzichte van de gebruikte Ohmse weerstand.

```{figure} ../figures/circuit.*
:label: fig:opstelling
:width: 80%

Schematische weergave van de circuits. (boven) De functiegenerator (Keysight EDU33212AA) staat in serie met de weerstand $R_0$ en de condensator $C_0$. De spanning over de condensator wordt gemeten met de oscilloscoop (Keysight EDUX1052A). (onder) De uitgangsspanning van het eerste filter bestaande uit $R_1$ en $C_1$ wordt gefilterd door $R_2$ en $C_2$. De spanning over $C_2$ wordt gemeten met de oscilloscoop.
```

## Meetprocedure
De spanningsoverdracht van beide filters wordt bepaald door de peak-to-peak spanning van het ingangssignaal en het uitgangssignaal te meten met de oscilloscoop. De frequentie varieert tussen $10 \mathrm{Hz} en $100 \mathrm{kHz}$ met stapgrootte factor $1.5$. Dat zorgt voor voor een gelijke verdeling van de meetpunten op een logaritmische schaal met een bereik ver boven en onder de cut-off frequentie.

## Data-analyse
De spanningsoverdracht is gelijk aan de verhouding tussen de peak-to-peak spanning van het ingangssignaal en het uitgangssignaal. Voor het doorrekenen van de onzekerheden wordt de calculus methode toegepast. De onzekerheid in de meetwaarden volgt uit de specificaties van de gebruikte apparatuur. 
Om de overeenstemming tussen de theorie en het experiment te onderzoeken wordt ook een theoretisch model gefit met behulp van de least-squares methode. Voor het eerste orde filter fitten we vergelijking \ref{eq:theorie} in de vorm

$$ \label{eq:fit_1}
    V_{\text{gain}} = \frac{1}{\sqrt{1 + \left( 2\pi f \alpha \right)^2}}
$$

met $\alpha$ als onbekende. We verwachten $\alpha \approx R_0 \cdot C_0$. Voor het tweede orde filter fitten we de functie

$$ \label{eq:fit_2}
    V_{\text{gain}} = \frac{1}{\sqrt{ \left(2\pi f \beta \right)^2 + \left(1-2\pi^2f^2 \gamma \right)^2 }}
$$

met $\beta$ en $\gamma$ onbekend. We verwachten $\beta \approx R_1 \left[ C_1 + C_2 \right] + R_2 \cdot C_2$ en $\gamma \approx R_1 \cdot R_2 \cdot C_1 \cdot C_2$. In de fit wordt een initiële schatting van de verwachte orde grootte gegeven.