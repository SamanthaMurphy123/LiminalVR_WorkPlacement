using UnityEngine;
using TMPro;
using System.Collections;

[System.Serializable]
public class Subtitle
{
    public TextMeshProUGUI textBox;
    public float startTime;
    public float endTime;
}

[System.Serializable]
public class Stage
{
    public string stageName;
    public Subtitle[] subtitles;
}

public class SubtitleManager : MonoBehaviour
{
    public Stage[] stages;
    public Transform target;
    public GameObject breathingTimerPrefab; // Reference to the breathing timer prefab
    private GameObject breathingTimerInstance; // Instance of the breathing timer

    void Start()
    {
        foreach (var stage in stages)
        {
            foreach (var subtitle in stage.subtitles)
            {
                subtitle.textBox.gameObject.SetActive(false);
            }
        }

        StartCoroutine(DisplaySubtitles());
    }

    IEnumerator DisplaySubtitles()
    {
        float currentTime = 0f;

        foreach (var stage in stages)
        {
            Debug.Log("Starting Stage: " + stage.stageName);
            foreach (var subtitle in stage.subtitles)
            {
                yield return new WaitForSeconds(subtitle.startTime - currentTime);
                currentTime = subtitle.startTime;

                subtitle.textBox.gameObject.SetActive(true);
                subtitle.textBox.transform.parent.LookAt(target);
                subtitle.textBox.transform.parent.rotation = Quaternion.LookRotation(subtitle.textBox.transform.parent.position - target.position);
                Debug.Log("Displaying Subtitle: " + subtitle.textBox.text);

                // Trigger breathing exercise based on specific subtitle times
                if (ShouldStartBreathingExercise(subtitle.startTime))
                {
                    StartBreathingExercise();
                }

                yield return new WaitForSeconds(subtitle.endTime - subtitle.startTime);
                currentTime = subtitle.endTime;

                subtitle.textBox.gameObject.SetActive(false);
                Debug.Log("Hiding Subtitle: " + subtitle.textBox.text);
            }
        }
    }

    private bool ShouldStartBreathingExercise(float startTime)
    {
        // Define the specific times that should trigger the breathing exercise
        float[] breathingExerciseStartTimes = { 1f, 60f, 136f, 270f };

        foreach (float time in breathingExerciseStartTimes)
        {
            if (Mathf.Approximately(startTime, time))
            {
                return true;
            }
        }

        return false;
    }

    private void StartBreathingExercise()
    {
        if (breathingTimerInstance == null)
        {
            breathingTimerInstance = Instantiate(breathingTimerPrefab);
            breathingTimerInstance.transform.position = target.position + target.forward * 2f;
            breathingTimerInstance.transform.rotation = Quaternion.LookRotation(breathingTimerInstance.transform.position - target.position);
        }

        BreathingTimer breathingTimer = breathingTimerInstance.GetComponent<BreathingTimer>();
        if (breathingTimer != null)
        {
            breathingTimer.StartBreathingCycle();
        }
    }
}
