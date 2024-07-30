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

                yield return new WaitForSeconds(subtitle.endTime - subtitle.startTime);
                currentTime = subtitle.endTime;

                subtitle.textBox.gameObject.SetActive(false);
                Debug.Log("Hiding Subtitle: " + subtitle.textBox.text);
            }
        }
    }
}
