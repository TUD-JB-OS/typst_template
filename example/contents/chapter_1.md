---
abstract: This is an example of a Typst based thesis template for Delft University of Technology. It includes options for cover page, abstract, ToC, logos, fonts, colors and more. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
---

# Introduction
Hoogfrequente signalen zorgen regelmatig voor verstoringen in electronische meetsystemen. Het is dan wenselijk om deze signalen te filteren met een laagdoorlaatfilter. Het eenvoudigste passieve filter bestaat uit een weerstand in serie met een condensator: het RCfilter. Omdat de condensator in de limiet van hoge frequenties als weerstandsloze draad beschreven kan worden, zorgt alleen een laagfrequent signaal voor spanning over deze condensator. Door meerdere van deze filters in serie te schakelen, kan een hogere orde filter verkregen worden. Hoewel het gedrag van deze systemen onder ideale omstandigheden goed te beschrijven is, kunnen er in de praktijk onregelmatigheden voorkomen wanneer de componenten niet ideaal zijn. Daarom is het doel van dit onderzoek om de karakteristiek van de spanningsoverdracht van een eerste en tweede orde filter experimenteel te bepalen en te vergelijken. De spanningsoverdracht van de filters wordt experimenteel bepaald door de uitgangsspanning over de condensator te meten bij verschillende frequenties boven en onder de cut-off frequentie. Het theoretisch model wordt vervolgens gefit aan de verkregen data.



## Theoretische achtergrond

Een condensator is een component waarin lading wordt opgeslagen. In het meest eenvoudige geval bestaat deze uit twee parallelle platen. Wanneer er stroom door de condensator loopt, bouwt er een ladingsverschil op wardoor het opladen minder snel gaat. De spanning $V(t)$ (in $\mathrm{V}$) over de condensator in serie met een weerstand tijdens het opladen met een constante bronspanning wordt gegeven door 

$$    V(t)=V_0e^{t/\tau}$$

waar $V_0$ (in $\mathrm{V}$) de aangeboden spanning is, en $\tau$ (in $\mathrm{s}$) de $RC$-tijd gegeven door $R\cdot C$, met $R$ de weerstandswaarde van de in serie geschakelde Ohmse weerstand (in $\mathrm{\Omega}$) en $C$ de capaciteit van de condensator (in $\mathrm{C/V}$ of $\mathrm{F}$) \cite{wolfson2009essential}. 

Wanneer de spanningsbron een wisselspanning aanbiedt zal de condensator bij lage frequenties opladen en een tegenspanning geven waardoor deze minder snel oplaadt. Bij hoge frequenties zal de condensator zich echter gaan gedragen als weerstandsloze draad (de impedenatie convergeert naar 0). De karakteristieke frequentie die de overgang van het ene naar het andere domein beschrijft is de zogenaamde cut-off frequentie:

$$ f_c = \frac{1}{2\pi RC}. $$

Dit is de frequentie waar het vermogen gehalveerd is, of de verhouding tussen de gemiddelde spanning over de condensator en de ingangsspanning $1/\sqrt{2} \approx 0.71$ is. Deze verhouding kan beschreven worden met 
$$ \label{eq:theorie}
    \frac{V_C}{V_{in}} = \frac{1}{\sqrt{1+(2\pi f RC)^2}}
$$

waar $f$ ($\mathrm{Hz}$) de frequentie van de ingangspanning is \cite{storey2006electronics}. In de limiet van oneindige frequentie zeggen we dat de overdracht afneemt met $20$ $\mathrm{dB / decade}$. Door twee van deze $RC$-filters in serie te schakelen kan een tweede orde filter verkregen worden waar de overdracht afneemt met $40$ $\mathrm{dB / decade}$. De overdracht neemt dan dus twee keer zo snel af.

