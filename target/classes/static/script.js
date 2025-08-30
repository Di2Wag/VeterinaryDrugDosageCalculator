const drugSearchInput = document.getElementById('drug-search');
const drugDataList = document.getElementById('drug-list');
const formulationSelect = document.getElementById('formulation-select');
const petWeightInput = document.getElementById('pet-weight');
const calculateButton = document.getElementById('calculate-button');
const calculatedDosageDiv = document.getElementById('calculated-dosage');
const speciesRadios = document.getElementsByName('species');

//API endpoint URLs 
const API_URL = 'http://localhost:8080/api';

//Fetching the drug list for the database
const fetchingDrugList = async() => {
    try{
        const response = await fetch(`${API_URL}/drugs`);
        const drugs = await response.json();

        drugDataList.innerHTML = '';

        drugs.forEach (drug => {
            const option = document.createElement('option');
            option.value = drug.genericName;
            drugDataList.appendChild(option);
        });
    }catch (error) {
        console.error('Error fetching the drugs:', error);
    }
}

//Fetching the formulations
const fetchingFormulations = async (drugGenericName) => {
    if (!drugGenericName) {
        formulationSelect.innerHTML = '';
        return;
    }

    try {
        const response = await fetch(`${API_URL}/)formulations?drugGenericName=${encodeURIComponent(drugGenericName)}`);
        const formulations = await response.json();

        formulationSelect.innerHTML = '<option value="">--Select a formulation--</option>';

        formulations.forEach (formulation => {
            const option = document.createElement('option');
            option.value = formulation.id;
            option.textContent = `${formulation.concentration} ${formulation.concentrationUnit} per ${formulation.denominatorValue} ${formulation.denominatorUnit} (${formulation.presentationForm})`;
            formulationSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Error fetching the formulations:', error);
    }
}

//Event listener for drug selection
drugSearchInput.addEventListener('change', () => {
    const drugName = drugSearchInput.value;
    fetchingFormulations(drugName);
});

//Event listener for the calculate button
calculateButton.addEventListener('click', async () => {

    //gather all inputs
    const drugName = drugSearchInput.value;
    const formulationId = formulationSelect.value;
    const petWeight = petWeightInput.value;

    //define species
    let selectSpecies = null;
    for (const radio of speciesRadios) {
        if (radio.checked) {
            selectSpecies = radio.value;
            break;
        }
    }

    //validation
    if (!drugName || !formulationId || !petWeight || !selectSpecies) {
        calculatedDosageDiv.textContent = 'Please fill in all fields.';
        return;
    }

    //preparing data to send to backend
    const requestBody = {
        drugName: drugName,
        formulationId: parseInt(formulationId),
        species: selectSpecies,
        weight: parseFloat(petWeight)
    };

    try {
        const response = await fetch (`${API_URL}/calculate-dose`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Server responded with a ${response.status} error: ${errorText}`);
        }

        const result = await response.json();

        calculatedDosageDiv.textContent = `Administer: ${result.dose} ${result.unit}`;
    } catch (error) {
        console.error('Calculation failed:', error);
        calculatedDosageDiv.textContent = `Error: ${error.message || 'Could not calculate dose.'}`;
    }
});

document.addEventListener('DOMContentLoaded', fetchingDrugList);
